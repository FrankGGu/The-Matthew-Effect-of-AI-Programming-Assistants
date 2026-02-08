-module(min_deletions).
-export([min_deletions/2]).

min_deletions(S, K) ->
    Count = lists:foldl(fun(Char, Acc) -> 
        maps:update_with(Char, fun(Val) -> Val + 1 end, 1, Acc) 
    end, maps:new(), S),
    Sorted = lists:sort(fun({_, V1}, {_, V2}) -> V1 > V2 end, maps:to_list(Count)),
    Deletions = 0,
    min_deletions(Sorted, K, Deletions, 0).

min_deletions([], _, Deletions, _) ->
    Deletions;
min_deletions([{Char, Count} | Rest], K, Deletions, Distinct) when Distinct < K ->
    min_deletions(Rest, K, Deletions, Distinct + 1);
min_deletions([{Char, Count} | Rest], K, Deletions, Distinct) ->
    min_deletions(Rest, K, Deletions + (Count - 1), Distinct).