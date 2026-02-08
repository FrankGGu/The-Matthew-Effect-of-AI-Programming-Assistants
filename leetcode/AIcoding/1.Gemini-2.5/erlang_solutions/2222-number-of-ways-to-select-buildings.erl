-module(solution).
-export([number_of_ways/1]).

number_of_ways(S) ->
    % S is already a list of characters (string)

    % Calculate total counts of '0's and '1's
    {TotalZeros, TotalOnes} = lists:foldl(
        fun(Char, {Z, O}) ->
            case Char of
                $0 -> {Z + 1, O};
                $1 -> {Z, O + 1};
                _ -> {Z, O}
            end
        end,
        {0, 0},
        S
    ),

    % Iterate through the string, treating each character as the middle building.
    % Accumulator: {CurrentZerosLeft, CurrentOnesLeft, TotalWays}
    % CurrentZerosLeft: count of '0's encountered so far (to the left of current char)
    % CurrentOnesLeft: count of '1's encountered so far (to the left of current char)
    % TotalWays: accumulated number of valid triplets
    element(3, lists:foldl(
        fun(Char, {CurrentZerosLeft, CurrentOnesLeft, TotalWays}) ->
            case Char of
                $0 ->
                    % If current char is '0', it can be the middle of a "101" pattern.
                    % We need '1's to its left (CurrentOnesLeft)
                    % and '1's to its right.
                    % '1's to the right = TotalOnes - CurrentOnesLeft (since current char is '0', it doesn't affect '1' counts)
                    OnesAfter = TotalOnes - CurrentOnesLeft,
                    NewTotalWays = TotalWays + (CurrentOnesLeft * OnesAfter),
                    {CurrentZerosLeft + 1, CurrentOnesLeft, NewTotalWays};
                $1 ->
                    % If current char is '1', it can be the middle of a "010" pattern.
                    % We need '0's to its left (CurrentZerosLeft)
                    % and '0's to its right.
                    % '0's to the right = TotalZeros - CurrentZerosLeft (since current char is '1', it doesn't affect '0' counts)
                    ZerosAfter = TotalZeros - CurrentZerosLeft,
                    NewTotalWays = TotalWays + (CurrentZerosLeft * ZerosAfter),
                    {CurrentZerosLeft, CurrentOnesLeft + 1, NewTotalWays};
                _ ->
                    % Should not happen for binary strings
                    {CurrentZerosLeft, CurrentOnesLeft, TotalWays}
            end
        end,
        {0, 0, 0}, % Initial state
        S
    )).