-module(solution).
-export([longestSemiRepetitiveSubstring/1]).

-include_lib("array/include/array.hrl").

longestSemiRepetitiveSubstring(S) ->
    N = length(S),
    if
        N =:= 0 -> 0;
        true ->
            StringArray = array:from_list(S),
            % Parameters: StringArray, N, Right (current index to expand window),
            %             Left (leftmost index of current window),
            %             Count (number of adjacent identical pairs in window),
            %             MaxLen (maximum length found so far).
            % Right starts at 1 (0-indexed), Left starts at 0.
            % Initial MaxLen is 1 for non-empty string.
            loop(StringArray, N, 1, 0, 0, 1)
    end.

loop(StringArray, N, Right, Left, Count, MaxLen) when Right < N ->
    % Get characters at Right and Right-1 (0-indexed)
    CharRight = array:get(Right, StringArray),
    CharRightMinus1 = array:get(Right - 1, StringArray),

    % Update Count based on the new character
    NewCount = if CharRight =:= CharRightMinus1 -> Count + 1;
                 true -> Count
               end,

    % Shrink window from Left if NewCount exceeds 2
    {FinalLeft, FinalCount} = shrink_window(StringArray, Left, NewCount),

    % Update MaxLen with the current window length
    NewMaxLen = max(MaxLen, Right - FinalLeft + 1),

    % Continue to the next character
    loop(StringArray, N, Right + 1, FinalLeft, FinalCount, NewMaxLen);
loop(_StringArray, _N, _Right, _Left, _Count, MaxLen) ->
    % All characters processed, return the maximum length found
    MaxLen.

shrink_window(StringArray, Left, Count) ->
    shrink_loop(StringArray, Left, Count).

shrink_loop(StringArray, Left, Count) when Count > 2 ->
    % Check if the pair (S[Left], S[Left+1]) is identical
    % This pair is about to be removed from the window
    CharLeft = array:get(Left, StringArray),
    CharLeftPlus1 = array:get(Left + 1, StringArray),

    DecrementedCount = if CharLeft =:= CharLeftPlus1 -> Count - 1;
                         true -> Count
                       end,
    % Move Left pointer to the right
    shrink_loop(StringArray, Left + 1, DecrementedCount);
shrink_loop(_StringArray, Left, Count) ->
    % Count is now <= 2, stop shrinking
    {Left, Count}.