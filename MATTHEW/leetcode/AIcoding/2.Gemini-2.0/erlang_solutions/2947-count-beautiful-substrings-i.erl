-module(count_beautiful_substrings).
-export([count_beautiful_substrings/2]).

count_beautiful_substrings(S, K) ->
    count_beautiful_substrings(S, K, 0).

count_beautiful_substrings(S, K, Acc) ->
    Len = length(S),
    count_beautiful_substrings(S, K, 0, 1, Len, Acc).

count_beautiful_substrings(_S, _K, _I, Len, MaxLen, Acc) when Len > MaxLen ->
    Acc;
count_beautiful_substrings(S, K, I, Len, MaxLen, Acc) ->
    Sub = string:sub(S, I + 1, Len),
    Vowels = count_vowels(Sub),
    Consonants = Len - Vowels,
    NewAcc = case Vowels == Consonants andalso Vowels * Consonants rem K == 0 of
        true -> Acc + 1;
        false -> Acc
    end,
    case I + Len >= MaxLen of
        true -> count_beautiful_substrings(S, K, 0, Len + 1, MaxLen, NewAcc);
        false -> count_beautiful_substrings(S, K, I + 1, Len, MaxLen, NewAcc)
    end.

count_vowels(Str) ->
    count_vowels(Str, 0).

count_vowels(Str, Acc) ->
    count_vowels(Str, 1, Acc).

count_vowels(Str, Index, Acc) when Index > length(Str) ->
    Acc;
count_vowels(Str, Index, Acc) ->
    Char = string:substr(Str, Index, 1),
    NewAcc = case Char of
        "a" -> Acc + 1;
        "e" -> Acc + 1;
        "i" -> Acc + 1;
        "o" -> Acc + 1;
        "u" -> Acc + 1;
        _ -> Acc
    end,
    count_vowels(Str, Index + 1, NewAcc).