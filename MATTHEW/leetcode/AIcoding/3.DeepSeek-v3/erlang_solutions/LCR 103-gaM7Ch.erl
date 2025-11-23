-module(solution).
-export([coin_change/2]).

coin_change(Coins, Amount) ->
    Max = Amount + 1,
    Dp = lists:duplicate(Amount + 1, Max),
    Dp1 = setelement(1, Dp, 0),
    lists:foldl(
        fun(Coin, Acc) ->
            lists:foldl(
                fun(I, DpAcc) ->
                    if
                        I >= Coin ->
                            case element(I - Coin + 1, DpAcc) of
                                infinity -> DpAcc;
                                Val -> setelement(I + 1, DpAcc, min(element(I + 1, DpAcc), Val + 1))
                            end;
                        true -> DpAcc
                    end
                end,
                Acc,
                lists:seq(Coin, Amount))
        end,
        Dp1,
        Coins),
    case element(Amount + 1, lists:foldl(
        fun(Coin, Acc) ->
            lists:foldl(
                fun(I, DpAcc) ->
                    if
                        I >= Coin ->
                            case element(I - Coin + 1, DpAcc) of
                                infinity -> DpAcc;
                                Val -> setelement(I + 1, DpAcc, min(element(I + 1, DpAcc), Val + 1))
                            end;
                        true -> DpAcc
                    end
                end,
                Acc,
                lists:seq(Coin, Amount))
        end,
        Dp1,
        Coins)) of
        Max -> -1;
        Res -> Res
    end.