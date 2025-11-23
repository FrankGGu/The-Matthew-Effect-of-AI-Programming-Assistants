-module(solution).
-export([distinctSubseqII/1]).

distinctSubseqII(S) ->
    Mod = 1000000007,

    % LastOccurrenceCount: an array of 26 integers, initialized to 0.
    % Each index i corresponds to character 'a' + i.
    % It stores the number of distinct subsequences ending with that character
    % that were formed *before* the current character is processed.
    LastOccurrenceCount = array:new(26, 0),

    % TotalDistinctSubsequences: a running total of distinct non-empty subsequences.
    TotalDistinctSubsequences = 0,

    % Iterate through the string S (which is a list of characters).
    {FinalTotal, _} = lists:foldl(fun(Char, Acc) ->
                                    % Acc is a tuple {CurrentTotal, CurrentLastOccurrenceCount}
                                    {CurrentTotal, CurrentLastOccurrenceCount} = Acc,

                                    % Calculate the array index for the current character ('a' is 0, 'b' is 1, etc.)
                                    CharIndex = Char - $a,

                                    % Calculate the number of new distinct subsequences that end with 'Char'.
                                    % These are formed by appending 'Char' to all previously found distinct subsequences,
                                    % plus 'Char' itself as a single-character subsequence.
                                    NewSubsequencesEndingWithChar = (CurrentTotal + 1) rem Mod,

                                    % Retrieve the count of subsequences that ended with 'Char' from its previous occurrence.
                                    % These are the duplicates that need to be subtracted to maintain distinctness.
                                    SubsequencesToRemove = array:get(CharIndex, CurrentLastOccurrenceCount),

                                    % Update the total distinct subsequences.
                                    % Add the newly formed subsequences and subtract the duplicates.
                                    NewTotal = (CurrentTotal + NewSubsequencesEndingWithChar - SubsequencesToRemove) rem Mod,

                                    % Ensure the result is non-negative after modulo operation.
                                    FinalNewTotal = (NewTotal + Mod) rem Mod,

                                    % Update the LastOccurrenceCount for the current character with the new count.
                                    UpdatedLastOccurrenceCount = array:set(CharIndex, NewSubsequencesEndingWithChar, CurrentLastOccurrenceCount),

                                    % Return the updated accumulator for the next iteration.
                                    {FinalNewTotal, UpdatedLastOccurrenceCount}
                                end, {TotalDistinctSubsequences, LastOccurrenceCount}, S),

    % The foldl returns {FinalTotal, _}, so we extract the FinalTotal.
    FinalTotal.