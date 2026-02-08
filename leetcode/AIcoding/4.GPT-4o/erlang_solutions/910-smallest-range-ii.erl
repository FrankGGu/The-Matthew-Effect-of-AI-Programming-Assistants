-module(solution).
-export([smallest_range_ii/2]).

smallest_range_ii(A, K) ->
    Min = lists:min(A),
    Max = lists:max(A),
    Sorted = lists:sort(A),
    N = length(Sorted),
    case N of
        1 -> 0;
        _ ->
            Res1 = Max - Min,
            Res2 = lists:foldl(fun(X, Acc) ->
                NewMin = min(Min + K, X + K),
                NewMax = max(Max - K, X - K),
                min(Acc, NewMax - NewMin)
            end, Res1, Sorted),
            Res2
    end.