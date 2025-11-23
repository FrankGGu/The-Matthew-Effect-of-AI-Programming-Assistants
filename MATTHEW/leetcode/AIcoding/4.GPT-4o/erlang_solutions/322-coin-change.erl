-spec coin_change(Coins :: [integer()], Amount :: integer()) -> integer().
coin_change(Coins, Amount) ->
    coin_change(Coins, Amount, [0 | lists:duplicate(Amount, -1)]).

coin_change(_, 0, Result) -> lists:nthtail(1, Result);
coin_change(_, _, []) -> -1;
coin_change([Coin | Rest], Amount, [Head | Tail]) when Amount >= Coin ->
    NewAmount = Amount - Coin,
    NewHead = case lists:nth(NewAmount, Tail) of
                -1 -> Head + 1;
                X -> min(Head + 1, X)
              end,
    coin_change(Rest, Amount, [NewHead | Tail]);
coin_change([_ | Rest], Amount, [_ | Tail]) -> coin_change(Rest, Amount, Tail).
