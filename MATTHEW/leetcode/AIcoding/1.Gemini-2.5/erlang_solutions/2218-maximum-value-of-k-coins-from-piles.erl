-module(solution).
-export([max_value_of_k_coins/2]).

-include_lib("array/include/array.hrl").

max_value_of_k_coins(Piles, K) ->
    % DP[i] will store the maximum value for i coins.
    % Initialize DP with 0 for 0 coins, and 0 for all other coins.
    % Using an array for efficient access and update.
    % Array is 0-indexed, from 0 to K.
    InitialDPArray = array:new({0, K}, [{0, 0}]),

    % Fold over each pile, updating the DP array.
    FinalDPArray = lists:foldl(
        fun(Pile, CurrentDPArray) ->
            % Calculate prefix sums for the current pile.
            % Prefixes[j] will be the sum of the first j coins from the pile.
            % Prefixes is an array, 0-indexed, where Prefixes[0] = 0, Prefixes[1] = first coin, etc.
            PileLen = length(Pile),
            PrefixSumsArray = calculate_prefix_sums_array(Pile),

            % Update the DP array for the current pile.
            update_dp_for_pile(CurrentDPArray, PrefixSumsArray, PileLen, K)
        end,
        InitialDPArray,
        Piles
    ),

    % The result is the maximum value for K coins, which is at index K.
    array:get(K, FinalDPArray).

calculate_prefix_sums_array(Pile) ->
    PrefixList = lists:foldl(fun(Coin, Acc) ->
        Acc ++ [lists:last(Acc) + Coin]
    end, [0], Pile),
    array:from_list(PrefixList).

update_dp_for_pile(DPArray, PrefixSumsArray, PileLen, MaxK) ->
    % Iterate `c` (total coins) from `MaxK` down to `0`.
    % This requires a recursive function to simulate the descending loop.
    update_dp_for_pile_recursive(DPArray, PrefixSumsArray, PileLen, MaxK, MaxK).

update_dp_for_pile_recursive(DPArray, _PrefixSumsArray, _PileLen, _MaxK, -1) ->
    DPArray; % Base case: all `c` values processed.
update_dp_for_pile_recursive(DPArray, PrefixSumsArray, PileLen, MaxK, CurrentC) ->
    % For each CurrentC, iterate `j` (coins from current pile) from `0` up to `min(CurrentC, PileLen)`.
    % J is the number of coins taken from the current pile.

    % Initialize MaxVal for CurrentC with the value from not taking any coins from the current pile.
    % This handles the J=0 case: array:get(CurrentC, DPArray) + PrefixSumsArray[0] (which is 0).
    CurrentMaxVal = array:get(CurrentC, DPArray),

    % Fold over possible number of coins 'J' taken from the current pile.
    % J ranges from 1 up to min(CurrentC, PileLen).
    NewValueForC = lists:foldl(
        fun(J, AccMaxVal) ->
            % PrevDPValue is the maximum value for (CurrentC - J) coins from previous piles.
            PrevDPValue = array:get(CurrentC - J, DPArray),
            % PileSum is the value of taking J coins from the current pile.
            PileSum = array:get(J, PrefixSumsArray),

            max(AccMaxVal, PrevDPValue + PileSum)
        end,
        CurrentMaxVal, % Initial accumulator value (option of taking 0 coins from current pile)
        lists:seq(1, min(CurrentC, PileLen)) % J goes from 1 to min(CurrentC, PileLen)
    ),

    UpdatedDPArray = array:set(CurrentC, NewValueForC, DPArray),
    update_dp_for_pile_recursive(UpdatedDPArray, PrefixSumsArray, PileLen, MaxK, CurrentC - 1).