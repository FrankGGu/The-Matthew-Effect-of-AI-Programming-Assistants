-spec change(Amount :: integer(), Coins :: [integer()]) -> integer().
change(Amount, Coins) ->
    DP = lists:duplicate(Amount + 1, 0),
    DP1 = lists:sublist(DP, 1, 1) ++ [1 | lists:sublist(DP, 2, Amount)],
    lists:foldl(
        fun(Coin, Acc) ->
            lists:foldl(
                fun(I, Dp) ->
                    case I >= Coin of
                        true -> 
                            lists:sublist(Dp, 1, I) ++ 
                            [lists:nth(I - Coin + 1, Dp) + lists:nth(I + 1, Dp) | 
                             lists:sublist(Dp, I + 2, Amount - I)];
                        false -> Dp
                    end
                end,
                Acc,
                lists:seq(1, Amount)
            )
        end,
        DP1,
        Coins
    ).