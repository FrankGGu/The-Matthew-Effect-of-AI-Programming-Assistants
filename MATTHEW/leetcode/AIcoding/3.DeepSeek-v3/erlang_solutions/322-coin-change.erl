-module(coin_change).
-export([coinChange/2]).

coinChange(Coins, Amount) ->
    Max = Amount + 1,
    Dp = array:new([{size, Max}, {default, Max}]),
    Dp1 = array:set(0, 0, Dp),
    coinChange(Coins, Amount, 1, Dp1).

coinChange(Coins, Amount, I, Dp) when I =< Amount ->
    lists:foldl(fun(C, Acc) ->
                    case I >= C of
                        true ->
                            Val = array:get(I - C, Acc) + 1,
                            case Val < array:get(I, Acc) of
                                true -> array:set(I, Val, Acc);
                                false -> Acc
                            end;
                        false -> Acc
                    end
                end, Dp, Coins),
    coinChange(Coins, Amount, I + 1, Dp);
coinChange(_Coins, Amount, _I, Dp) ->
    case array:get(Amount, Dp) > Amount of
        true -> -1;
        false -> array:get(Amount, Dp)
    end.