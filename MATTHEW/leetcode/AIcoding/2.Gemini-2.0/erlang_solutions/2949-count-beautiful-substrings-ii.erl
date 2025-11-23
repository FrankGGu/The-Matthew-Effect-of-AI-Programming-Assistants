-module(count_beautiful_substrings_ii).
-export([count_vowel_consonant_substrings/2]).

count_vowel_consonant_substrings(S, K) ->
    N = length(S),
    count_vowel_consonant_substrings_helper(S, K, N, 0, 0, 0, []).

count_vowel_consonant_substrings_helper(_S, _K, _N, I, Count, Result, _Map) when I > _N - 1 ->
    Result;

count_vowel_consonant_substrings_helper(S, K, N, I, Count, Result, Map) ->
    count_vowel_consonant_substrings_helper(S, K, N, I + 1, 0, Result + count_substrings(S, K, I, N), Map).

count_substrings(S, K, Start, N) ->
    count_substrings_helper(S, K, Start, N, Start, 0).

count_substrings_helper(S, K, Start, N, End, Count) when End > N - 1 ->
    Count;

count_substrings_helper(S, K, Start, N, End, Count) ->
    Sub = string:slice(S, Start, End - Start + 1),
    Len = length(Sub),
    Vowels = lists:foldl(fun(C, Acc) -> if is_vowel(C) -> Acc + 1; true -> Acc end end, 0, Sub),
    Consonants = Len - Vowels,
    if Vowels * Consonants == K ->
        count_substrings_helper(S, K, Start, N, End + 1, Count + 1);
    true ->
        count_substrings_helper(S, K, Start, N, End + 1, Count)
    end.

is_vowel(Char) ->
    case Char of
        $a -> true;
        $e -> true;
        $i -> true;
        $o -> true;
        $u -> true;
        _ -> false
    end.