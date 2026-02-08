-module(solution).
-export([coinChange/2]).

coinChange(_Coins, Amount) when Amount < 0 ->
    -1;
coinChange(_Coins, 0) ->
    0;
coinChange(Coins, Amount) ->
    % Initialize dp array: dp[i] stores the minimum coins for amount i.
    % Size is Amount + 1.
    % Initialize with Amount + 1, representing an unreachable state (infinity).
    % dp[0] is 0, as 0 coins are needed for amount 0.
    DP = gb_array:new([{size, Amount + 1}, {default, Amount + 1}]),
    DP0 = gb_array:set(0, 0, DP),

    % Iterate from 1 up to Amount to fill the dp table.
    FinalDP = lists:foldl(
        fun(I, CurrentDP) ->
            % For each amount I, find the minimum coins needed.
            MinCoinsForI = lists:foldl(
                fun(Coin, AccMin) ->
                    PrevAmount = I - Coin,
                    if
                        PrevAmount >= 0 ->
                            % Get the minimum coins for PrevAmount.
                            PrevCoins = gb_array:get(PrevAmount, CurrentDP),
                            if
                                % If PrevAmount was unreachable, this path is also unreachable.
                                PrevCoins =:= Amount + 1 ->
                                    AccMin;
                                true ->
                                    % Otherwise, update AccMin with PrevCoins + 1.
                                    min(AccMin, PrevCoins + 1)
                            end;
                        true ->
                            % If PrevAmount is negative, this coin cannot be used.
                            AccMin
                    end
                end,
                Amount + 1, % Initialize current minimum for I to infinity.
                Coins
            ),
            % Set the calculated minimum coins for amount I in the DP array.
            gb_array:set(I, MinCoinsForI, CurrentDP)
        end,
        DP0,
        lists:seq(1, Amount)
    ),

    % The result is dp[Amount].
    Result = gb_array:get(Amount, FinalDP),

    % If Result is still Amount + 1 (infinity), it means the amount cannot be made.
    if
        Result =:= Amount + 1 ->
            -1;
        true ->
            Result
    end.