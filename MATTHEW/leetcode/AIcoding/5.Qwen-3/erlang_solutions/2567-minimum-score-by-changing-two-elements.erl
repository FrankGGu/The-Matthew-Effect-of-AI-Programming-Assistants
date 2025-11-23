-module(solution).
-export([minScore/1]).

minScore(Nums) ->
    Sorted = lists:sort(Nums),
    N = length(Sorted),
    Min = lists:min(Sorted),
    Max = lists:max(Sorted),
    case N of
        2 -> 0;
        _ -> 
            lists:foldl(fun(I, Acc) ->
                Diff = lists:nth(I + 1, Sorted) - lists:nth(I, Sorted),
                if Diff < Acc -> Diff; true -> Acc end
            end, Max - Min, lists:seq(0, N - 2))
    end.