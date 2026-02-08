-spec sum_subarray_mins(Arr :: [integer()]) -> integer().
sum_subarray_mins(Arr) ->
    N = length(Arr),
    Left = lists:duplicate(N, 0),
    Right = lists:duplicate(N, 0),
    {Left1, Stack1} = compute_left(Arr, Left, [], 0),
    {Right1, _} = compute_right(Arr, Right, [], N - 1),
    Mod = 1000000007,
    lists:foldl(fun(I, Sum) ->
        (Sum + (lists:nth(I + 1, Arr) * lists:nth(I + 1, Left1) * lists:nth(I + 1, Right1)) rem Mod) rem Mod
    end, 0, lists:seq(0, N - 1)).

compute_left([], Left, Stack, _) -> {Left, Stack};
compute_left([H | T], Left, Stack, I) ->
    {NewStack, NewLeft} = process_stack(Left, Stack, H, I),
    NewLeft1 = setelement(I + 1, NewLeft, I - (if NewStack == [] -> -1; true -> hd(NewStack) end)),
    compute_left(T, NewLeft1, [I | NewStack], I + 1).

compute_right(Arr, Right, Stack, I) when I < 0 -> {Right, Stack};
compute_right(Arr, Right, Stack, I) ->
    H = lists:nth(I + 1, Arr),
    {NewStack, NewRight} = process_stack(Right, Stack, H, I),
    NewRight1 = setelement(I + 1, NewRight, (if NewStack == [] -> length(Arr); true -> hd(NewStack) end) - I),
    compute_right(Arr, NewRight1, [I | NewStack], I - 1).

process_stack(List, Stack, Val, I) ->
    case Stack of
        [] -> {Stack, List};
        [Top | Rest] ->
            case lists:nth(Top + 1, List) >= Val of
                true -> process_stack(List, Rest, Val, I);
                false -> {Stack, List}
            end
    end.