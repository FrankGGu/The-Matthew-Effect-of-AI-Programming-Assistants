-spec min_operations(Nums :: [integer()]) -> integer().
min_operations(Nums) ->
    Sorted = lists:sort(Nums),
    N = length(Sorted),
    Unique = lists:usort(Sorted),
    M = length(Unique),
    Left = 0,
    Right = 0,
    Result = N,
    min_operations(Unique, Left, Right, M, N, Result).

min_operations(Unique, Left, Right, M, N, Result) ->
    if Right >= M ->
        Result;
    true ->
        Current = lists:nth(Right + 1, Unique),
        Min = Current - N + 1,
        NewLeft = find_left(Unique, Left, Right, Min),
        NewResult = min(Result, N - (Right - NewLeft + 1)),
        min_operations(Unique, NewLeft, Right + 1, M, N, NewResult)
    end.

find_left(Unique, Left, Right, Min) ->
    if Left > Right ->
        Left;
    true ->
        Current = lists:nth(Left + 1, Unique),
        if Current < Min ->
            find_left(Unique, Left + 1, Right, Min);
        true ->
            Left
        end
    end.