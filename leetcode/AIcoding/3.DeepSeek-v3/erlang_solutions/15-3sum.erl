-spec three_sum(Nums :: [integer()]) -> [[integer()]].
three_sum(Nums) ->
    Sorted = lists:sort(Nums),
    three_sum(Sorted, length(Sorted), []).

three_sum(_, Length, Acc) when Length < 3 ->
    lists:reverse(Acc);
three_sum([H | T], Length, Acc) ->
    case Length > 3 andalso H =:= lists:nth(1, T) of
        true ->
            three_sum(T, Length - 1, Acc);
        false ->
            NewAcc = two_sum(T, -H, H, Acc),
            three_sum(T, Length - 1, NewAcc)
    end.

two_sum(Nums, Target, First, Acc) ->
    two_sum(Nums, Target, First, 0, length(Nums) - 1, Acc).

two_sum(Nums, Target, First, Left, Right, Acc) when Left < Right ->
    LeftVal = lists:nth(Left + 1, Nums),
    RightVal = lists:nth(Right + 1, Nums),
    Sum = LeftVal + RightVal,
    if
        Sum =:= Target ->
            NewAcc = [[First, LeftVal, RightVal] | Acc],
            NewLeft = skip_duplicates(Nums, Left, 1),
            NewRight = skip_duplicates(Nums, Right, -1),
            two_sum(Nums, Target, First, NewLeft, NewRight, NewAcc);
        Sum < Target ->
            NewLeft = skip_duplicates(Nums, Left, 1),
            two_sum(Nums, Target, First, NewLeft, Right, Acc);
        true ->
            NewRight = skip_duplicates(Nums, Right, -1),
            two_sum(Nums, Target, First, Left, NewRight, Acc)
    end;
two_sum(_, _, _, _, _, Acc) ->
    Acc.

skip_duplicates(Nums, Index, Step) ->
    Val = lists:nth(Index + 1, Nums),
    NewIndex = Index + Step,
    case NewIndex >= 0 andalso NewIndex < length(Nums) of
        true ->
            NewVal = lists:nth(NewIndex + 1, Nums),
            if
                NewVal =:= Val ->
                    skip_duplicates(Nums, NewIndex, Step);
                true ->
                    NewIndex
            end;
        false ->
            NewIndex
    end.