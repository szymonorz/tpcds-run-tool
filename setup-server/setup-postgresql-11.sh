wget https://ftp.postgresql.org/pub/source/v14.1/postgresql-14.1.tar.bz2
tar jxvf postgresql-14.1.tar.bz2
HOMEDIR=`pwd`
(
  cd postgresql-14.1
  ./configure --prefix=$HOMEDIR/postgresql-14.1-inst
  make -j10
  make install
)
export PGDATA=$HOMEDIR/pgdata

./postgresql-14.1-inst/bin/initdb

./postgresql-14.1-inst/bin/pg_ctl -D $PGDATA -l pglogfile start

# ALTER SYSTEM SET shared_buffers TO '4096MB';
./postgresql-14.1-inst/bin/createdb test

echo "ALTER SYSTEM SET shared_buffers TO '4096MB';" |
 ./postgresql-14.1-inst/bin/psql test

./postgresql-14.1-inst/bin/pg_ctl -D $PGDATA  stop
./postgresql-14.1-inst/bin/pg_ctl -D $PGDATA -l pglogfile start

