-module(solution).
-export([select_data/2]).

select_data(Records, MinScore) ->
    lists:filter(fun(Record) -> maps:get(score, Record) > MinScore end, Records).