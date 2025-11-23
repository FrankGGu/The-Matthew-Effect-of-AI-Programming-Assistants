-module(solution).
-export([change/2]).

%% Dynamic Programming approach to solve the Coin Change II problem.
-spec change(integer(), [integer()]) -> integer().
change(Amount, Coins) ->
    %% Initialize a list of size Amount+1 with 0, except dp[0] = 1 (1 way to make 0)
    Dp = lists:duplicate(Amount + 1, 0),
    Dp1 = lists:replace(1, 1, Dp),
    %% Iterate over each coin denomination
    lists:foldl(fun(Coin, DpAcc) ->
                     %% Update the dp array for each coin
                     lists:foldl(fun(AmountIdx, DpAcc2) ->
                                     case AmountIdx >= Coin of
                                         true -> lists:replace(AmountIdx, DpAcc2:element(AmountIdx - Coin + 1) + DpAcc2:element(AmountIdx), DpAcc2);
                                         false -> DpAcc2
                                     end
                                 end, DpAcc, lists:seq(Coin, Amount))
                 end, Dp1, Coins).
