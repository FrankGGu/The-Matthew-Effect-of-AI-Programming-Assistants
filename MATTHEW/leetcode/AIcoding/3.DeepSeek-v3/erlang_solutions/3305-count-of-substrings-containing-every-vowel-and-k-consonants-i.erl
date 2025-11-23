-spec count_substrings(S :: unicode:unicode_binary(), K :: integer()) -> integer().
count_substrings(S, K) ->
    Vowels = sets:from_list("aeiou"),
    SList = unicode:characters_to_list(S),
    Len = length(SList),
    count_substrings(SList, Vowels, K, 0, Len, 0).

count_substrings(_, _, _, I, Len, Count) when I >= Len -> Count;
count_substrings(S, Vowels, K, I, Len, Count) ->
    case is_vowel(lists:nth(I + 1, S), Vowels) of
        true ->
            count_substrings(S, Vowels, K, I + 1, Len, Count);
        false ->
            NewCount = check_substrings(S, Vowels, K, I, Len, 0, 0, 0, Count),
            count_substrings(S, Vowels, K, I + 1, Len, NewCount)
    end.

check_substrings(_, _, _, I, Len, _, _, _, Count) when I >= Len -> Count;
check_substrings(S, Vowels, K, I, Len, V, C, J, Count) ->
    Char = lists:nth(J + 1, S),
    case is_vowel(Char, Vowels) of
        true ->
            NewV = V + 1,
            NewC = C;
        false ->
            NewV = V,
            NewC = C + 1
    end,
    if
        NewV >= 5 andalso NewC =:= K ->
            check_substrings(S, Vowels, K, I, Len, NewV, NewC, J + 1, Count + 1);
        true ->
            check_substrings(S, Vowels, K, I, Len, NewV, NewC, J + 1, Count)
    end.

is_vowel(Char, Vowels) ->
    sets:is_element(Char, Vowels).