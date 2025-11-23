-spec longest_monotonic_subarray(Nums :: [integer()]) -> integer().
longest_monotonic_subarray(Nums) ->
    case Nums of
        [] -> 0;
        [_] -> 1;
        _ ->
            {MaxInc, MaxDec, CurrInc, CurrDec} = lists:foldl(
                fun(Num, {MaxInc, MaxDec, CurrInc, CurrDec}) ->
                    {NewInc, NewDec} = case Num > CurrInc of
                        true -> {Num, Num};
                        false -> case Num < CurrDec of
                            true -> {Num, Num};
                            false -> {Num, Num}
                        end
                    end,
                    NewCurrInc = case Num > CurrInc of
                        true -> CurrInc + 1;
                        false -> 1
                    end,
                    NewCurrDec = case Num < CurrDec of
                        true -> CurrDec + 1;
                        false -> 1
                    end,
                    NewMaxInc = max(MaxInc, NewCurrInc),
                    NewMaxDec = max(MaxDec, NewCurrDec),
                    {NewMaxInc, NewMaxDec, NewInc, NewDec}
                end,
                {1, 1, hd(Nums), hd(Nums)},
                tl(Nums)
            ),
            max(MaxInc, MaxDec)
    end.