-module(solution).
-export([change/2]).

change(Amount, Coins) ->
    % Initialize DP array: dp[0] = 1 (one way to make amount 0, by using no coins),
    % and all other dp[i] are 0.
    % The array size is Amount + 1 to store values from 0 to Amount.
    DP0 = array:set(0, 1, array:new([{size, Amount + 1}, {fixed, true}, {default, 0}])),

    % Iterate through each coin in the Coins list.
    % For each coin, update the DP array for all amounts from the coin's value up to the target Amount.
    FinalDP = lists:foldl(fun(Coin, CurrentDP) ->
        % For the current Coin, iterate through amounts from Coin to Amount.
        lists:foldl(fun(A, AccDP) ->
            % AccDP is the current state of the DP array.
            % dp[A] represents the number of ways to make amount A using coins processed so far.
            % To update dp[A] with the current Coin:
            % Add the number of ways to make (A - Coin) to dp[A].
            % This is because if we use the current Coin, the remaining amount (A - Coin)
            % must be made up by previously considered coins (or the current coin if it's used multiple times).
            PrevWays = array:get(A, AccDP),
            WaysFromSmallerAmount = array:get(A - Coin, AccDP),
            array:set(A, PrevWays + WaysFromSmallerAmount, AccDP)
        end, CurrentDP, lists:seq(Coin, Amount))
    end, DP0, Coins),

    % The final result is the number of ways to make the target Amount.
    array:get(Amount, FinalDP).