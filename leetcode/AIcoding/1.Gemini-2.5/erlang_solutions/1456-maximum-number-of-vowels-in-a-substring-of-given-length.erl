-module(solution).
-export([max_vowels/2]).

is_vowel($a) -> 1;
is_vowel($e) -> 1;
is_vowel($i) -> 1;
is_vowel($o) -> 1;
is_vowel($u) -> 1;
is_vowel(_) -> 0.

max_vowels(S, K) ->
    N = length(S),

    %% Handle edge cases for K
    if K =< 0 ->
        0;
       K >= N ->
        %% If K is greater than or equal to the string length,
        %% the entire string is the only possible window.
        lists:foldl(fun(Char, Acc) -> Acc + is_vowel(Char) end, 0, S);
       true ->
        %% Convert the string (list of characters) to a binary for O(1) character access by index.
        BinS = list_to_binary(S),

        %% Calculate the vowel count for the initial window (S[0...K-1]).
        InitialVowelCount = calculate_initial_vowels(BinS, K, 0, 0),

        %% Start the sliding window process.
        %% CurrentLeavingIndex starts at 0, meaning the character at index 0
        %% will be the first one to leave the window as it slides.
        slide_window(BinS, K, N, InitialVowelCount, InitialVowelCount, 0)
    end.

calculate_initial_vowels(_BinS, K, K, Acc) ->
    Acc;
calculate_initial_vowels(BinS, K, Index, Acc) ->
    Char = binary:at(BinS, Index),
    calculate_initial_vowels(BinS, K, Index + 1, Acc + is_vowel(Char)).

slide_window(BinS, K, N, CurrentVowelCount, MaxVowelCount, CurrentLeavingIndex) when CurrentLeavingIndex + K >= N ->
    %% Base case: The window has slid past the end of the string.
    %% The last possible window starts at N - K.
    %% When CurrentLeavingIndex reaches N - K + 1, the character entering
    %% would be at index (N - K + 1) + K = N + 1, which is out of bounds.
    MaxVowelCount;
slide_window(BinS, K, N, CurrentVowelCount, MaxVowelCount, CurrentLeavingIndex) ->
    %% Get the character leaving the window.
    CharLeaving = binary:at(BinS, CurrentLeavingIndex),

    %% Get the character entering the window.
    CharEntering = binary:at(BinS, CurrentLeavingIndex + K),

    %% Update the current vowel count.
    NewCurrentVowelCount = CurrentVowelCount - is_vowel(CharLeaving) + is_vowel(CharEntering),

    %% Update the maximum vowel count found so far.
    NewMaxVowelCount = max(MaxVowelCount, NewCurrentVowelCount),

    %% Recurse with the window slid one position to the right.
    slide_window(BinS, K, N, NewCurrentVowelCount, NewMaxVowelCount, CurrentLeavingIndex + 1).