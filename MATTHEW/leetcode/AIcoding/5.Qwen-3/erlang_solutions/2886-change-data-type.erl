-module(solution).
-export([change_data_type/1]).

change_data_type(Data) ->
    lists:map(fun({Id, Name, Age}) -> {Id, Name, integer(Age)} end, Data).