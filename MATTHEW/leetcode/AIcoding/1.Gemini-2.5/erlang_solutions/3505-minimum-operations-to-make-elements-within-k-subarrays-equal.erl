-module(solution).
-export([min_operations/2]).

min_operations(Nums, _K) ->
    N = length(Nums),
    FreqMap = lists:foldl(fun(X, Acc) ->
                                  maps:update_with(X, fun(Count) -> Count + 1 end, 1, Acc)
                          end, maps:new(), Nums),
    case maps:is_empty(FreqMap) of
        true ->
            0;
        false ->
            MaxFreq = lists:max(maps:values(FreqMap)),
            N - MaxFreq
    end.