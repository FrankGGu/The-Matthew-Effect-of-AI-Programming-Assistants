-module(solution).
-export([minimum_swaps/1]).

digit_sum(N) ->
    digit_sum(N, 0).

digit_sum(0, Sum) -> Sum;
digit_sum(N, Sum) ->
    digit_sum(N div 10, Sum + (N rem 10)).

minimum_swaps(Nums) ->
    NumsWithIndex = lists:zip(lists:seq(0, length(Nums) - 1, Nums),
    Sorted = lists:sort(fun({_, A}, {_, B}) ->
        SumA = digit_sum(A),
        SumB = digit_sum(B),
        if
            SumA == SumB -> A =< B;
            true -> SumA =< SumB
        end
    end, NumsWithIndex),
    Visited = lists:duplicate(length(Nums), false),
    {Swaps, _} = count_swaps(Sorted, Visited, 0, 0),
    Swaps.

count_swaps([], _, Swaps, _) -> {Swaps, []};
count_swaps([{OrigIdx, _} | Rest], Visited, Swaps, CurrentIdx) ->
    case lists:nth(OrigIdx + 1, Visited) of
        true ->
            count_swaps(Rest, Visited, Swaps, CurrentIdx + 1);
        false ->
            {CycleSize, NewVisited} = find_cycle(OrigIdx, CurrentIdx, Rest, Visited, 0),
            count_swaps(Rest, NewVisited, Swaps + (CycleSize - 1), CurrentIdx + 1)
    end.

find_cycle(OrigIdx, CurrentIdx, Sorted, Visited, CycleSize) ->
    case lists:nth(OrigIdx + 1, Visited) of
        true ->
            {CycleSize, Visited};
        false ->
            NewVisited = setelement(OrigIdx + 1, Visited, true),
            {NewOrigIdx, _} = lists:nth(CurrentIdx + 1, Sorted),
            find_cycle(NewOrigIdx, CurrentIdx, Sorted, NewVisited, CycleSize + 1)
    end.