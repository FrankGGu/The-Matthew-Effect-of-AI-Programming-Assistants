-module(solution).
-export([countNicePairs/1]).

-define(MOD, 1000000007).

rev(N) when N >= 0 ->
    rev(N, 0).

rev(0, Acc) ->
    Acc;
rev(N, Acc) ->
    rev(N div 10, Acc * 10 + (N rem 10)).

countNicePairs(Nums) ->
    % Step 1: Build a frequency map for (Num - rev(Num)) values.
    % The map stores {Value => Count}.
    FreqMap = lists:foldl(
        fun(Num, AccMap) ->
            Val = Num - rev(Num),
            maps:update_with(Val, fun(Count) -> Count + 1 end, 1, AccMap)
        end,
        #{},
        Nums
    ),

    % Step 2: Iterate through the frequency map and calculate total nice pairs.
    % For each value with frequency C, it contributes C * (C - 1) / 2 pairs.
    TotalPairs = maps:fold(
        fun(_Val, Count, AccTotal) ->
            if Count > 1 ->
                % Calculate the number of pairs for this specific 'Val'
                % C * (C - 1) / 2
                % Erlang integers handle arbitrary precision, so intermediate products won't overflow.
                PairsForThisVal = Count * (Count - 1) div 2,
                % Add to the running total, ensuring modulo operation at each step
                (AccTotal + PairsForThisVal) rem ?MOD;
            true ->
                AccTotal
            end
        end,
        0,
        FreqMap
    ),
    TotalPairs.