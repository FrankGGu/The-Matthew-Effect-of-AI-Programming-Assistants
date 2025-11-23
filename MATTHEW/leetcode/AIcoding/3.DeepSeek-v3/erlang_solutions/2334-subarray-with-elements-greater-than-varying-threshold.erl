-spec subarray_with_elements_greater_than_varying_threshold(Nums :: [integer()], Threshold :: integer()) -> integer().
subarray_with_elements_greater_than_varying_threshold(Nums, Threshold) ->
    N = length(Nums),
    Left = lists:duplicate(N, -1),
    Right = lists:duplicate(N, N),
    Stack = [],
    {Left1, _} = process_stack(Nums, Left, Stack, 0),
    Stack1 = [],
    {Right1, _} = process_stack_reverse(Nums, Right, Stack1, N - 1),
    find_min_length(Nums, Left1, Right1, Threshold, -1).

process_stack([], Left, _, _) -> {Left, []};
process_stack([H | T], Left, Stack, I) ->
    NewStack = case Stack of
        [] -> [];
        [{Val, _} | _] when Val >= H -> process_stack([H | T], Left, tl(Stack), I);
        _ -> Stack
    end,
    NewLeft = case NewStack of
        [] -> setelement(I + 1, Left, -1);
        [{_, Pos} | _] -> setelement(I + 1, Left, Pos)
    end,
    process_stack(T, NewLeft, [{H, I} | NewStack], I + 1).

process_stack_reverse([], Right, _, _) -> {Right, []};
process_stack_reverse([H | T], Right, Stack, I) ->
    NewStack = case Stack of
        [] -> [];
        [{Val, _} | _] when Val >= H -> process_stack_reverse([H | T], Right, tl(Stack), I);
        _ -> Stack
    end,
    NewRight = case NewStack of
        [] -> setelement(I + 1, Right, length(Right));
        [{_, Pos} | _] -> setelement(I + 1, Right, Pos)
    end,
    process_stack_reverse(T, NewRight, [{H, I} | NewStack], I - 1).

find_min_length(_, _, _, _, MinLen, -1) -> MinLen;
find_min_length(Nums, Left, Right, Threshold, MinLen, I) ->
    Len = lists:nth(I + 1, Right) - lists:nth(I + 1, Left) - 1,
    Val = lists:nth(I + 1, Nums),
    NewMinLen = if
        Val * Len > Threshold ->
            case MinLen of
                -1 -> Len;
                _ -> min(Len, MinLen)
            end;
        true -> MinLen
    end,
    find_min_length(Nums, Left, Right, Threshold, NewMinLen, I - 1).

find_min_length(Nums, Left, Right, Threshold, I) ->
    find_min_length(Nums, Left, Right, Threshold, -1, I).