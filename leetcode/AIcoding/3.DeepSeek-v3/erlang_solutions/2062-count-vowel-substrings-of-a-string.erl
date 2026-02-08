-spec count_vowel_substrings(Word :: unicode:unicode_binary()) -> integer().
count_vowel_substrings(Word) ->
    Vowels = sets:from_list("aeiou"),
    N = byte_size(Word),
    Count = 0,
    count_substrings(Word, Vowels, N, Count).

count_substrings(Word, Vowels, N, Count) when N < 5 ->
    Count;
count_substrings(Word, Vowels, N, Count) ->
    case is_vowel_substring(Word, 0, N, Vowels, sets:new()) of
        true -> 
            NewCount = Count + 1,
            count_substrings(Word, Vowels, N - 1, NewCount);
        false ->
            count_substrings(Word, Vowels, N - 1, Count)
    end + count_substrings(binary:part(Word, 1, N - 1), Vowels, N - 1, Count).

is_vowel_substring(Word, I, N, Vowels, Seen) when I < N ->
    Char = binary:at(Word, I),
    case sets:is_element(Char, Vowels) of
        true ->
            NewSeen = sets:add_element(Char, Seen),
            is_vowel_substring(Word, I + 1, N, Vowels, NewSeen);
        false ->
            false
    end;
is_vowel_substring(_Word, _I, _N, Vowels, Seen) ->
    sets:size(Seen) =:= 5.