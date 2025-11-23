-module(solution).
-export([kth_distinct/2]).

kth_distinct(StrArray, K) ->
    Distincts = lists:filter(fun(X) -> lists:count(StrArray, X) == 1 end, StrArray),
    case lists:nth(K, Distincts) of
        undefined -> <<"">>;
        Result -> Result
    end.