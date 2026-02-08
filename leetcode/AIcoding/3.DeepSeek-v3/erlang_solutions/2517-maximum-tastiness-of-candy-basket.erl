-spec maximum_tastiness(Price :: [integer()], K :: integer()) -> integer().
maximum_tastiness(Price, K) ->
    Sorted = lists:sort(Price),
    N = length(Sorted),
    Low = 0,
    High = lists:last(Sorted) - lists:nth(1, Sorted),
    binary_search(Sorted, K, Low, High, -1).

binary_search(Sorted, K, Low, High, Ans) when Low =< High ->
    Mid = (Low + High) div 2,
    case can_select(Sorted, K, Mid) of
        true -> binary_search(Sorted, K, Mid + 1, High, Mid);
        false -> binary_search(Sorted, K, Low, Mid - 1, Ans)
    end;
binary_search(_, _, _, _, Ans) ->
    Ans.

can_select(Sorted, K, Diff) ->
    Count = 1,
    Last = lists:nth(1, Sorted),
    can_select(Sorted, K, Diff, Count, Last, 2, length(Sorted)).

can_select(_, K, _, Count, _, _, _) when Count >= K ->
    true;
can_select(Sorted, K, Diff, Count, Last, I, N) when I =< N ->
    Curr = lists:nth(I, Sorted),
    if
        Curr - Last >= Diff ->
            can_select(Sorted, K, Diff, Count + 1, Curr, I + 1, N);
        true ->
            can_select(Sorted, K, Diff, Count, Last, I + 1, N)
    end;
can_select(_, _, _, _, _, _, _) ->
    false.