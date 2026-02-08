-spec three_sum(Nums :: [integer()]) -> [[integer()]].
three_sum(Nums) ->
    Sorted = lists:sort(Nums),
    three_sum(Sorted, [], 0, length(Sorted)).

three_sum(_, Acc, I, Len) when I >= Len - 2 ->
    Acc;
three_sum(Sorted, Acc, I, Len) ->
    case I > 0 andalso lists:nth(I, Sorted) =:= lists:nth(I + 1, Sorted) of
        true ->
            three_sum(Sorted, Acc, I + 1, Len);
        false ->
            Target = -lists:nth(I, Sorted),
            Left = I + 1,
            Right = Len - 1,
            NewAcc = two_sum(Sorted, Left, Right, Target, Acc),
            three_sum(Sorted, NewAcc, I + 1, Len)
    end.

two_sum(Sorted, Left, Right, Target, Acc) ->
    case Left >= Right of
        true ->
            Acc;
        false ->
            Sum = lists:nth(Left, Sorted) + lists:nth(Right, Sorted),
            if
                Sum < Target ->
                    two_sum(Sorted, Left + 1, Right, Target, Acc);
                Sum > Target ->
                    two_sum(Sorted, Left, Right - 1, Target, Acc);
                true ->
                    A = lists:nth(Left, Sorted),
                    B = lists:nth(Right, Sorted),
                    NewAcc = [[-Target, A, B] | Acc],
                    NewLeft = Left + 1,
                    NewRight = Right - 1,
                    NewLeft1 = case NewLeft < Right andalso lists:nth(NewLeft, Sorted) =:= A of
                                   true -> NewLeft + 1;
                                   false -> NewLeft
                               end,
                    NewRight1 = case NewRight > Left andalso lists:nth(NewRight, Sorted) =:= B of
                                    true -> NewRight - 1;
                                    false -> NewRight
                                end,
                    two_sum(Sorted, NewLeft1, NewRight1, Target, NewAcc)
            end
    end.