-spec max_distance(Position :: [integer()], M :: integer()) -> integer().
max_distance(Position, M) ->
    Sorted = lists:sort(Position),
    N = length(Sorted),
    Low = 1,
    High = lists:nth(N, Sorted) - lists:nth(1, Sorted),
    binary_search(Sorted, Low, High, M, -1).

binary_search(Sorted, Low, High, M, Result) when Low =< High ->
    Mid = (Low + High) div 2,
    case can_place(Sorted, Mid, M) of
        true ->
            binary_search(Sorted, Mid + 1, High, M, Mid);
        false ->
            binary_search(Sorted, Low, Mid - 1, M, Result)
    end;
binary_search(_, _, _, _, Result) ->
    Result.

can_place(Sorted, MinDist, M) ->
    Count = 1,
    LastPos = lists:nth(1, Sorted),
    can_place(Sorted, 2, length(Sorted), MinDist, M, Count, LastPos).

can_place(Sorted, I, N, MinDist, M, Count, LastPos) when I =< N ->
    CurrentPos = lists:nth(I, Sorted),
    if
        CurrentPos - LastPos >= MinDist ->
            NewCount = Count + 1,
            if
                NewCount >= M -> true;
                true -> can_place(Sorted, I + 1, N, MinDist, M, NewCount, CurrentPos)
            end;
        true ->
            can_place(Sorted, I + 1, N, MinDist, M, Count, LastPos)
    end;
can_place(_, _, _, _, M, Count, _) ->
    Count >= M.