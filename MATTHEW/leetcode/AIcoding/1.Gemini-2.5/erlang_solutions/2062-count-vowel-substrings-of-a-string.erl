-module(solution).
-export([countVowelSubstrings/1]).

is_vowel(Char) ->
    case Char of
        $a -> true;
        $e -> true;
        $i -> true;
        $o -> true;
        $u -> true;
        _ -> false
    end.

vowel_to_index(Char) ->
    case Char of
        $a -> 0;
        $e -> 1;
        $i -> 2;
        $o -> 3;
        $u -> 4
    end.

count_at_most_k(Word, K) ->
    WordArray = array:from_list(Word),
    Len = array:size(WordArray),
    count_at_most_k_loop(WordArray, Len, K, 0, 0, array:new(5, 0), 0, 0).

count_at_most_k_loop(WordArray, Len, K, Left, Right, Counts, UniqueVowels, Acc) ->
    if Right >= Len ->
        Acc;
    true ->
        CharRight = array:get(Right, WordArray),
        if is_vowel(CharRight) ->
            IdxRight = vowel_to_index(CharRight),
            OldCount = array:get(IdxRight, Counts),
            NewCounts1 = array:set(IdxRight, OldCount + 1, Counts),
            NewUniqueVowels1 = if OldCount == 0 -> UniqueVowels + 1; true -> UniqueVowels end,

            {NewLeft, FinalCounts, FinalUniqueVowels} = adjust_left(WordArray, K, Left, Right, NewCounts1, NewUniqueVowels1),

            NewAcc = Acc + (Right - NewLeft + 1),
            count_at_most_k_loop(WordArray, Len, K, NewLeft, Right + 1, FinalCounts, FinalUniqueVowels, NewAcc);
        true -> % CharRight is a consonant
            count_at_most_k_loop(WordArray, Len, K, Right + 1, Right + 1, array:new(5, 0), 0, Acc)
        end
    end.

adjust_left(WordArray, K, Left, Right, Counts, UniqueVowels) ->
    if UniqueVowels > K ->
        CharLeft = array:get(Left, WordArray),
        IdxLeft = vowel_to_index(CharLeft),
        OldCount = array:get(IdxLeft, Counts),
        NewCounts = array:set(IdxLeft, OldCount - 1, Counts),
        NewUniqueVowels = if OldCount == 1 -> UniqueVowels - 1; true -> UniqueVowels end,
        adjust_left(WordArray, K, Left + 1, Right, NewCounts, NewUniqueVowels);
    true ->
        {Left, Counts, UniqueVowels}
    end.

countVowelSubstrings(Word) ->
    count_at_most_k(Word, 5) - count_at_most_k(Word, 4).