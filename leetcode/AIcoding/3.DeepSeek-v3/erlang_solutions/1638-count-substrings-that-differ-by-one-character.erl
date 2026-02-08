-spec count_substrings(S :: unicode:unicode_binary(), T :: unicode:unicode_binary()) -> integer().
count_substrings(S, T) ->
    SList = binary_to_list(S),
    TList = binary_to_list(T),
    LenS = length(SList),
    LenT = length(TList),
    Count = 0,
    lists:foldl(
        fun(I, Acc1) ->
            lists:foldl(
                fun(J, Acc2) ->
                    Diff = 0,
                    K = 0,
                    {NewAcc, _, _} = 
                        lists:foldl(
                            fun(_, {Acc3, D, K1}) when K1 < LenS, K1 < LenT, I + K1 < LenS, J + K1 < LenT ->
                                if
                                    lists:nth(I + K1 + 1, SList) =/= lists:nth(J + K1 + 1, TList) ->
                                        if
                                            D == 0 -> {Acc3, D + 1, K1 + 1};
                                            true -> {Acc3, D, K1 + 1}
                                        end;
                                    true ->
                                        {Acc3, D, K1 + 1}
                                end;
                                (_, {Acc3, D, _}) ->
                                    {Acc3, D, 0}
                            end,
                            {Acc2, Diff, K},
                            lists:seq(1, min(LenS - I, LenT - J))
                        ),
                    if
                        element(2, NewAcc) == 1 -> element(1, NewAcc) + 1;
                        true -> element(1, NewAcc)
                    end
                end,
                Acc1,
                lists:seq(0, LenT - 1))
        end,
        Count,
        lists:seq(0, LenS - 1)).