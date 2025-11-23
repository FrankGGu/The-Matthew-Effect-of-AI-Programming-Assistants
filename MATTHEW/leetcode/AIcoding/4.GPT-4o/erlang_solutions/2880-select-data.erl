-module(solution).
-export([select_data/2]).

select_data(N, Data) ->
    lists:filter(fun(X) -> X rem N =:= 0 end, Data).