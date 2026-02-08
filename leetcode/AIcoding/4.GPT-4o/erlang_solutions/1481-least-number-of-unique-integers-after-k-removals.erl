-module(solution).
-export([find_least_num_unique_ints/2]).

find_least_num_unique_ints(Numbers, K) ->
    Counts = lists:foldl(fun(X, Acc) -> maps:update_with(X, fun(V) -> V + 1 end, fun() -> 1 end, Acc) end, map:new(), Numbers),
    SortedCounts = lists:sort(fun({_, C1}, {_, C2}) -> C1 < C2 end, maps:to_list(Counts)),
    remove_unique(SortedCounts, K).

remove_unique([], _) -> 0;
remove_unique([{_, Count} | Rest], K) when K >= Count -> remove_unique(Rest, K - Count);
remove_unique([{_, Count} | _], K) -> 1 + length(Rest).