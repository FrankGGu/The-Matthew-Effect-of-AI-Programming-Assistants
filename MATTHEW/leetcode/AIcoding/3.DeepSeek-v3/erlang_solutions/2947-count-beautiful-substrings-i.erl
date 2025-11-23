-spec count_beautiful_substrings(S :: unicode:unicode_binary(), K :: integer()) -> integer().
count_beautiful_substrings(S, K) ->
    N = byte_size(S),
    Count = 0,
    count_beautiful_substrings(S, K, N, Count).

count_beautiful_substrings(_, _, 0, Count) ->
    Count;
count_beautiful_substrings(S, K, N, Count) ->
    NewCount = check_substrings(S, K, N - 1, 0, 0, 0, Count),
    count_beautiful_substrings(S, K, N - 1, NewCount).

check_substrings(_, _, End, Start, _, _, Count) when Start > End ->
    Count;
check_substrings(S, K, End, Start, Vowels, Consonants, Count) ->
    Char = binary:at(S, Start),
    IsVowel = case Char of
        $a -> true;
        $e -> true;
        $i -> true;
        $o -> true;
        $u -> true;
        _ -> false
    end,
    NewVowels = case IsVowel of
        true -> Vowels + 1;
        false -> Vowels
    end,
    NewConsonants = case IsVowel of
        true -> Consonants;
        false -> Consonants + 1
    end,
    case (NewVowels =:= NewConsonants) andalso (NewVowels * NewConsonants rem K =:= 0) of
        true ->
            check_substrings(S, K, End, Start + 1, NewVowels, NewConsonants, Count + 1);
        false ->
            check_substrings(S, K, End, Start + 1, NewVowels, NewConsonants, Count)
    end.