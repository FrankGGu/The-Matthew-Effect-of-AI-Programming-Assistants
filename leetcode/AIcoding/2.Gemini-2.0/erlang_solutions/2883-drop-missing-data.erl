-module(solution).
-export([drop_missing_data/1]).

drop_missing_data(DataFrame) ->
  lists:filter(fun(Row) -> not lists:member(null, maps:values(Row)) end, DataFrame).