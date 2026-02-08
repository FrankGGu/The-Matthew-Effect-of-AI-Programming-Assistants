-spec maximal_square(Matrix :: [[char()]]) -> integer().
maximal_square(Matrix) ->
    case Matrix of
        [] -> 0;
        _ ->
            Rows = length(Matrix),
            Cols = length(hd(Matrix)),
            DP = lists:duplicate(Rows + 1, lists:duplicate(Cols + 1, 0)),
            MaxLen = 0,
            {_, Result} = lists:foldl(
                fun(I, {DPAcc, Max}) ->
                    RowDP = lists:nth(I + 1, DPAcc),
                    {NewRowDP, NewMax} = lists:foldl(
                        fun(J, {RowDPAcc, CurrentMax}) ->
                            case I > 0 andalso J > 0 andalso lists:nth(I, lists:nth(J, Matrix)) == $1 of
                                true ->
                                    Val = 1 + min([
                                        lists:nth(J, lists:nth(I, DPAcc)),
                                        lists:nth(J + 1, lists:nth(I, DPAcc)),
                                        lists:nth(J, lists:nth(I + 1, DPAcc))
                                    ]),
                                    NewRowDPAcc = setelement(J + 1, RowDPAcc, Val),
                                    {NewRowDPAcc, max(CurrentMax, Val)};
                                false ->
                                    {RowDPAcc, CurrentMax}
                            end
                        end,
                        {RowDP, Max},
                        lists:seq(1, Cols)
                    ),
                    NewDPAcc = setelement(I + 1, DPAcc, NewRowDP),
                    {NewDPAcc, NewMax}
                end,
                {DP, MaxLen},
                lists:seq(0, Rows - 1)
            ),
            Result * Result
    end.