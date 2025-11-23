-module(rename_columns).
-export([get_rename_sql/0]).

get_rename_sql() ->
    "ALTER TABLE Customers RENAME COLUMN id TO customer_id;".