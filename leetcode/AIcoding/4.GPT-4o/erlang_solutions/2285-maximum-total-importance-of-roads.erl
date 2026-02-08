-module(solution).
-export([maximum_total_importance/2]).

maximum_total_importance(N, roads) ->
    RoadCounts = lists:foldl(fun({X, Y}, Acc) ->
        Acc1 = lists:update_counter(X, 1, Acc),
        lists:update_counter(Y, 1, Acc1)
    end, lists:duplicate(N, 0), roads),
    SortedCounts = lists:sort(fun({_, A}, {_, B}) -> A > B end, lists:zip(lists:seq(0, N-1), RoadCounts)),
    Importance = lists:foldl(fun({Index, Count}, Acc) ->
        Acc + (Index + 1) * Count
    end, 0, lists:take(N, SortedCounts)),
    Importance.

lists:update_counter(Key, Delta, List) ->
    case lists:keyfind(Key, 1, List) of
        false -> [{Key, Delta} | List];
        {Key, Count} -> lists:keyreplace(Key, 1, List, {Key, Count + Delta})
    end.