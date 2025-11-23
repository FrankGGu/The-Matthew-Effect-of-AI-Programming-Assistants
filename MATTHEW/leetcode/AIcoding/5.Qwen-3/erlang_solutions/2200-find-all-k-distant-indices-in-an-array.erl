-module(solution).
-export([k_distant_indices/2]).

k_distant_indices(Array, K) ->
    Len = length(Array),
    Result = lists:seq(0, Len - 1),
    lists:filter(fun(I) -> 
        lists:any(fun(J) -> abs(I - J) =< K end, lists:seq(0, Len - 1))
    end, Result).