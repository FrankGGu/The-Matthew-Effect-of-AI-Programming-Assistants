-module(solution).
-export([max_vowels/2]).

max_vowels(S, K) ->
    Vowels = "aeiou",
    Length = string:len(S),
    max_vowels_helper(S, Vowels, K, Length, 0, 0).

max_vowels_helper(_, _, K, Length, Count, MaxCount) when Length < K ->
    MaxCount;
max_vowels_helper(S, Vowels, K, Length, Count, MaxCount) ->
    NewCount = Count + if lists:member(string:substr(S, Length - K + 1, 1), Vowels) -> 1; true -> 0 end,
    NewMaxCount = max(MaxCount, NewCount),
    PrevCount = Count - if lists:member(string:substr(S, Length - K, 1), Vowels) -> 1; true -> 0 end,
    max_vowels_helper(S, Vowels, K, Length - 1, PrevCount, NewMaxCount).