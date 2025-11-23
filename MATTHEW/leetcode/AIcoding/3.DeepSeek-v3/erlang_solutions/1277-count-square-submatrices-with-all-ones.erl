-spec count_squares(Matrix :: [[integer()]]) -> integer().
count_squares(Matrix) ->
    M = length(Matrix),
    N = length(hd(Matrix)),
    DP = lists:duplicate(M, lists:duplicate(N, 0)),
    {DP1, Sum} = lists:foldl(fun(I, {DPAcc, SumAcc}) ->
        Row = lists:nth(I + 1, Matrix),
        {NewRow, NewSum} = lists:foldl(fun(J, {RowAcc, RowSum}) ->
            case I =:= 0 orelse J =:= 0 of
                true ->
                    Val = lists:nth(J + 1, Row),
                    {lists:sublist(RowAcc, J) ++ [Val] ++ lists:nthtail(J + 1, RowAcc), RowSum + Val};
                false ->
                    case lists:nth(J + 1, Row) of
                        0 ->
                            {lists:sublist(RowAcc, J) ++ [0] ++ lists:nthtail(J + 1, RowAcc), RowSum};
                        1 ->
                            Min = lists:min([
                                lists:nth(J, lists:nth(I, DPAcc)),
                                lists:nth(J + 1, lists:nth(I, DPAcc)),
                                lists:nth(J, lists:nth(I + 1, DPAcc))
                            ]),
                            NewVal = Min + 1,
                            {lists:sublist(RowAcc, J) ++ [NewVal] ++ lists:nthtail(J + 1, RowAcc), RowSum + NewVal}
                    end
            end
        end, {lists:nth(I + 1, DPAcc), SumAcc}, lists:seq(0, N - 1)),
        {lists:sublist(DPAcc, I) ++ [NewRow] ++ lists:nthtail(I + 1, DPAcc), NewSum}
    end, {DP, 0}, lists:seq(0, M - 1)),
    Sum.