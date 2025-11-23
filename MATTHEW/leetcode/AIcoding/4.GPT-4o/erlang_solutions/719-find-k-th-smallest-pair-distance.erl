-module(solution).
-export([smallest_distance_pair/2]).

smallest_distance_pair(Nums, K) ->
    Sorted = lists:sort(Nums),
    MinDist = 0,
    MaxDist = lists:last(Sorted) - lists:first(Sorted),
    find_kth_pair_distance(Sorted, K, MinDist, MaxDist).

find_kth_pair_distance(Sorted, K, MinDist, MaxDist) ->
    case MinDist > MaxDist of
        true -> MinDist;
        false ->
            MidDist = (MinDist + MaxDist) div 2,
            Count = count_pairs(Sorted, MidDist),
            case Count < K of
                true -> find_kth_pair_distance(Sorted, K, MidDist + 1, MaxDist);
                false -> find_kth_pair_distance(Sorted, K, MinDist, MidDist)
            end
    end.

count_pairs(Sorted, Distance) ->
    lists:foldl(fun(X, Acc) ->
        Acc + length(lists:filter(fun(Y) -> Y - X <= Distance end, lists:tl(Sorted)))
    end, 0, Sorted).