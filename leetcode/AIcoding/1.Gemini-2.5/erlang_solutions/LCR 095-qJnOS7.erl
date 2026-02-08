-module(solution).
-export([longest_common_subsequence/2]).

-spec longest_common_subsequence(Text1 :: unicode:unicode_binary(), Text2 :: unicode:unicode_binary()) -> integer().
longest_common_subsequence(Text1, Text2) ->
    Len1 = byte_size(Text1),
    Len2 = byte_size(Text2),

    % Initialize PrevRowArray as an array of zeros.
    % Size Len2 + 1 to accommodate indices from 0 to Len2.
    % array:new/1 creates a new array. Default value is 0.
    PrevRowArray = array:new([{size, Len2 + 1}, {fixed, true}, {default, 0}]),

    % Iterate through rows (I from 1 to Len1)
    % AccPrevRowArray represents dp[I-1]
    FinalRowArray = lists:foldl(
        fun(I, AccPrevRowArray) ->
            Char1 = binary:at(Text1, I - 1), % Get character from Text1 (0-indexed)

            % Initialize CurrRowArray for the current row dp[I]
            CurrRowArray = array:new([{size, Len2 + 1}, {fixed, true}, {default, 0}]),

            % The inner foldl iterates through columns (J from 1 to Len2).
            % It maintains a tuple state: {CurrentRowArrayBeingBuilt, LeftVal, DiagVal}
            % LeftVal = dp[I][J-1]
            % DiagVal = dp[I-1][J-1]
            {UpdatedCurrRowArray, _, _} = lists:foldl(
                fun(J, {AccCurrRowArray, LeftVal, DiagVal}) ->
                    Char2 = binary:at(Text2, J - 1), % Get character from Text2 (0-indexed)

                    CurrentVal =
                        if Char1 == Char2 ->
                            DiagVal + 1;
                        true ->
                            % max(dp[I-1][J], dp[I][J-1])
                            % dp[I-1][J] is at index J in AccPrevRowArray (0-indexed)
                            Val1 = array:get(J, AccPrevRowArray),
                            % dp[I][J-1] is LeftVal
                            Val2 = LeftVal,
                            max(Val1, Val2)
                        end,

                    % Update state for the next iteration:
                    % 1. Set CurrentVal at index J in AccCurrRowArray
                    % 2. CurrentVal becomes the new LeftVal for J+1
                    % 3. dp[I-1][J] becomes the new DiagVal for J+1 (from AccPrevRowArray)
                    { array:set(J, CurrentVal, AccCurrRowArray), CurrentVal, array:get(J, AccPrevRowArray) }
                end,
                % Initial state for J=1:
                % AccCurrRowArray starts as CurrRowArray (all zeros)
                % LeftVal = dp[I][0] = 0
                % DiagVal = dp[I-1][0] = 0 (from AccPrevRowArray at index 0)
                {CurrRowArray, 0, array:get(0, AccPrevRowArray)},
                lists:seq(1, Len2) % Iterate J from 1 to Len2
            ),
            UpdatedCurrRowArray % This becomes AccPrevRowArray for the next I iteration
        end,
        PrevRowArray, % Initial PrevRowArray (all zeros)
        lists:seq(1, Len1) % Iterate I from 1 to Len1
    ),
    % The final result is dp[Len1][Len2], which is at index Len2 in FinalRowArray
    array:get(Len2, FinalRowArray).