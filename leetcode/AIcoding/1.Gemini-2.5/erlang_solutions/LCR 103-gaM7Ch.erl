-module(solution).
-export([coinChange/2]).

-include_lib("kernel/include/array.hrl").

coinChange(Coins, Amount) ->
    Inf = Amount + 1, % Represents infinity, or an unreachable state. Max possible coins is Amount (if all coins are 1).

    % Initialize DP array: dp[0] = 0, dp[i] = Inf for i > 0
    % array:new(Size, [{default, DefaultValue}]) creates an array of Size elements,
    % all initialized to DefaultValue. Indices are 0 to Size-1.
    DPArray0 = array:new(Amount + 1, [{default, Inf}]),
    DPArray = array:set(0, 0, DPArray0),

    % Iterate from 1 to Amount to fill the DP array
    FinalDPArray = lists:foldl(
        fun(I, AccDP) ->
            % For each amount I, find the minimum coins
            CurrentMin = lists:foldl(
                fun(Coin, MinSoFar) ->
                    If (I - Coin >= 0) ->
                        PrevAmountMin = array:get(I - Coin, AccDP),
                        If (PrevAmountMin =/= Inf) ->
                            min(MinSoFar, PrevAmountMin + 1)
                        Else
                            MinSoFar
                        End
                    Else
                        MinSoFar
                    End
                end,
                Inf, % Initial minimum for current amount I is Inf
                Coins
            ),
            % Set the calculated minimum for amount I in the DP array
            array:set(I, CurrentMin, AccDP)
        end,
        DPArray,
        lists:seq(1, Amount) % Iterate I from 1 to Amount
    ),

    Result = array:get(Amount, FinalDPArray),

    If (Result =/= Inf) ->
        Result
    Else
        -1
    End.