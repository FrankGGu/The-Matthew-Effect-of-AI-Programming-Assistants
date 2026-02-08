-module(modify_columns).
-export([modify_columns/1]).

modify_columns(Data) ->
    lists:map(fun([Id, Name, Age]) -> [Id, string:to_upper(Name), Age] end, Data).