-module(solution).
-export([change/2]).

change(Amount, Coins) ->
    DP = array:set(0, 1, array:new([{size, Amount + 1}, {fixed, true}, {default, 0}])),

    lists:foldl(fun(Coin, CurrentDP) ->
        lists:foldl(fun(J, InnerDP) ->
            PrevWays = array:get(J - Coin, InnerDP),
            CurrentWays = array:get(J, InnerDP),
            array:set(J, CurrentWays + PrevWays, InnerDP)
        end, CurrentDP, lists:seq(Coin, Amount))
    end, DP, Coins),

    array:get(Amount, DP).