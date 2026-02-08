-module(solution).
-export([min_swaps/1]).

min_swaps(List) ->
    Pairs = lists:map(fun(X) -> {X, digit_sum(X)} end, List),
    Sorted = lists:sort(fun({A, _}, {B, _}) -> A < B end, Pairs),
    IndexMap = lists:zip(lists:seq(0, length(List) - 1), Sorted),
    Swaps = lists:map(fun({Index, {Value, _}}) -> {Index, Value} end, IndexMap),
    CountSwaps(Swaps, 0, []).

CountSwaps([], Count, Visited) -> Count;
CountSwaps([{Index, Value} | Rest], Count, Visited) ->
    if
        lists:member(Index, Visited) -> CountSwaps(Rest, Count, Visited);
        true ->
            NewCount = Count + 1,
            NewVisited = lists:foldl(fun({I, _}, Acc) -> [I | Acc] end, [Index], FollowCycle([{Index, Value} | Rest])),
            CountSwaps(Rest, NewCount, NewVisited)
    end.

FollowCycle([], _) -> [];
FollowCycle([{Index, _} | Rest], Swaps) ->
    case lists:member(Index, Swaps) of
        true -> FollowCycle(Rest, Swaps);
        false -> [Index | FollowCycle(Rest, Swaps)]
    end.

digit_sum(X) -> lists:sum(lists:map(fun(C) -> C - $0 end, string:to_integer(integer_to_list(X)))).