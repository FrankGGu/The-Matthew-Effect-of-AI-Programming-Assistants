-spec find_length_of_shortest_subarray(Arr :: [integer()]) -> integer().
find_length_of_shortest_subarray(Arr) ->
    N = length(Arr),
    Left = 0,
    Right = N - 1,
    {Left1, _} = find_non_decreasing(Arr, Left, 1),
    {_, Right1} = find_non_decreasing(Arr, Right, -1),
    if
        Left1 > Right1 -> 0;
        true ->
            MinLen = min(N - Left1 - 1, Right1),
            find_min_len(Arr, Left1, Right1, MinLen)
    end.

find_non_decreasing(Arr, I, Step) ->
    N = length(Arr),
    while_loop(Arr, I, Step, N).

while_loop(Arr, I, Step, N) ->
    Next = I + Step,
    if
        Next >= 0, Next < N, lists:nth(I + 1, Arr) =< lists:nth(Next + 1, Arr) ->
            while_loop(Arr, Next, Step, N);
        true ->
            if
                Step =:= 1 -> {I, undefined};
                true -> {undefined, I}
            end
    end.

find_min_len(Arr, Left, Right, MinLen) ->
    N = length(Arr),
    I = 0,
    J = Right,
    find_min_len_loop(Arr, I, J, Left, Right, N, MinLen).

find_min_len_loop(Arr, I, J, Left, Right, N, MinLen) ->
    if
        I > Left orelse J >= N -> MinLen;
        true ->
            case (J >= N) orelse (lists:nth(I + 1, Arr) =< lists:nth(J + 1, Arr)) of
                true ->
                    NewMinLen = min(MinLen, J - I - 1),
                    find_min_len_loop(Arr, I + 1, J, Left, Right, N, NewMinLen);
                false ->
                    find_min_len_loop(Arr, I, J + 1, Left, Right, N, MinLen)
            end
    end.