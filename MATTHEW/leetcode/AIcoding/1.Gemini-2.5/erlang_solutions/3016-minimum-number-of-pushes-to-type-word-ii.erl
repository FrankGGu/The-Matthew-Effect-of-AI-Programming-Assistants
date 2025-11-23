-module(solution).
-export([minimumPushes/1]).

minimumPushes(Words) ->
    % Initialize a list of 26 zeros to store character frequencies.
    % Index 0 corresponds to 'a', 1 to 'b', ..., 25 to 'z'.
    Freqs = lists:duplicate(26, 0),

    % Populate the frequency list by iterating through words and their characters.
    FinalFreqs = lists:foldl(
        fun(Word, AccFreqs) ->
            lists:foldl(
                fun(Char, CurrentAccFreqs) ->
                    % Calculate the index for the character (0-25)
                    Index = Char - $a,
                    % Increment the frequency for this character
                    % lists:replace_nth is 1-indexed, so we use Index + 1
                    lists:replace_nth(Index + 1, lists:nth(Index + 1, CurrentAccFreqs) + 1, CurrentAccFreqs)
                end,
                AccFreqs,
                Word
            )
        end,
        Freqs,
        Words
    ),

    % Filter out characters that did not appear (frequency is 0)
    % and sort the remaining frequencies in descending order.
    PositiveFreqs = lists:filter(fun(F) -> F > 0 end, FinalFreqs),
    SortedFreqs = lists:sort(fun(A, B) -> A >= B end, PositiveFreqs),

    % Calculate the total pushes.
    % The `calculate_pushes` function takes the sorted frequencies,
    % the current total pushes (initially 0), and the current character index (initially 0).
    calculate_pushes(SortedFreqs, 0, 0).

calculate_pushes([], TotalPushes, _Index) ->
    % Base case: no more frequencies to process, return the total pushes.
    TotalPushes;
calculate_pushes([Freq | Rest], TotalPushes, Index) ->
    % Calculate the cost for the current character.
    % There are 9 keys, and each key can hold 8 characters.
    % The cost for the 1st char on a key is 1, 2nd is 2, ..., 8th is 8.
    % Since there are 9 keys, the first 9 distinct characters get cost 1,
    % the next 9 get cost 2, and so on.
    % (Index div 9) gives 0 for Index 0-8, 1 for Index 9-17, etc.
    % Adding 1 gives the correct cost (1, 2, 3, ...).
    Cost = (Index div 9) + 1,

    % Add the pushes for the current character to the total.
    NewTotalPushes = TotalPushes + (Freq * Cost),

    % Recursively call for the rest of the frequencies, incrementing the index.
    calculate_pushes(Rest, NewTotalPushes, Index + 1).