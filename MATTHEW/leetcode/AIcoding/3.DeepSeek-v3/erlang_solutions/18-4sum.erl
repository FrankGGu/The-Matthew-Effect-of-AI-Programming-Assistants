-spec four_sum(Nums :: [integer()], Target :: integer()) -> [[integer()]].
four_sum(Nums, Target) ->
    Sorted = lists:sort(Nums),
    N = length(Sorted),
    Result = lists:foldl(
        fun(I, Acc1) ->
            lists:foldl(
                fun(J, Acc2) ->
                    Left = J + 1,
                    Right = N - 1,
                    Sum = Target - (lists:nth(I, Sorted) + lists:nth(J, Sorted)),
                    lists:foldl(
                        fun(_, Acc3) when Left >= Right -> Acc3;
                           (_, Acc3) ->
                            LVal = lists:nth(Left, Sorted),
                            RVal = lists:nth(Right, Sorted),
                            case LVal + RVal of
                                Sum ->
                                    Quad = [lists:nth(I, Sorted), lists:nth(J, Sorted), LVal, RVal],
                                    NewAcc = case lists:member(Quad, Acc3) of
                                               true -> Acc3;
                                               false -> [Quad | Acc3]
                                           end,
                                    four_sum_helper(Left + 1, Right - 1, LVal, RVal, Sorted, Sum, NewAcc);
                                S when S < Sum ->
                                    four_sum_helper(Left + 1, Right, LVal, RVal, Sorted, Sum, Acc3);
                                _ ->
                                    four_sum_helper(Left, Right - 1, LVal, RVal, Sorted, Sum, Acc3)
                            end
                        end,
                        Acc2,
                        lists:seq(1, N)
                end,
                Acc1,
                lists:seq(I + 1, N - 2))
        end,
        [],
        lists:seq(1, N - 3)),
    lists:reverse(Result).

four_sum_helper(Left, Right, LVal, RVal, Sorted, Sum, Acc) ->
    case Left >= Right of
        true -> Acc;
        false ->
            NewLVal = lists:nth(Left, Sorted),
            NewRVal = lists:nth(Right, Sorted),
            case NewLVal + NewRVal of
                Sum ->
                    Quad = [lists:nth(I, Sorted), lists:nth(J, Sorted), NewLVal, NewRVal],
                    case lists:member(Quad, Acc) of
                        true -> four_sum_helper(Left + 1, Right - 1, NewLVal, NewRVal, Sorted, Sum, Acc);
                        false -> four_sum_helper(Left + 1, Right - 1, NewLVal, NewRVal, Sorted, Sum, [Quad | Acc])
                    end;
                S when S < Sum ->
                    four_sum_helper(Left + 1, Right, NewLVal, NewRVal, Sorted, Sum, Acc);
                _ ->
                    four_sum_helper(Left, Right - 1, NewLVal, NewRVal, Sorted, Sum, Acc)
            end
    end.