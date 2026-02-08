-spec maximum_sum_of_heights(MaxHeights :: [integer()]) -> integer().
maximum_sum_of_heights(MaxHeights) ->
    N = length(MaxHeights),
    Left = lists:duplicate(N, 0),
    Right = lists:duplicate(N, 0),
    Stack = [],
    {Left1, _} = lists:foldl(fun(I, {Acc, St}) ->
        Val = lists:nth(I, MaxHeights),
        {NewSt, Sum} = process_stack(St, Val, I, MaxHeights),
        NewSum = case NewSt of
            [] -> Val * I;
            _ -> Sum + Val * (I - hd(NewSt))
        end,
        {setelement(I, Acc, NewSum), NewSt}
    end, {Left, Stack}, lists:seq(1, N)),

    Stack2 = [],
    {Right1, _} = lists:foldr(fun(I, {Acc, St}) ->
        Val = lists:nth(I, MaxHeights),
        {NewSt, Sum} = process_stack(St, Val, I, MaxHeights),
        NewSum = case NewSt of
            [] -> Val * (N - I + 1);
            _ -> Sum + Val * (hd(NewSt) - I)
        end,
        {setelement(I, Acc, NewSum), NewSt}
    end, {Right, Stack2}, lists:seq(N, 1, -1)),

    lists:max([lists:nth(I, Left1) + lists:nth(I, Right1) - lists:nth(I, MaxHeights) || I <- lists:seq(1, N)]).

process_stack(Stack, Val, I, MaxHeights) ->
    case Stack of
        [] -> {[I], 0};
        [Top | Rest] ->
            TopVal = lists:nth(Top, MaxHeights),
            if
                TopVal >= Val -> {[I], 0};
                true ->
                    {NewRest, Sum} = process_stack(Rest, Val, Top, MaxHeights),
                    {[I | NewRest], Sum + TopVal * (Top - hd(NewRest))}
            end
    end.