-spec count_vowels(Word :: unicode:unicode_binary()) -> integer().
count_vowels(Word) ->
    Vowels = sets:from_list("aeiou"),
    Bin = unicode:characters_to_binary(Word),
    Size = byte_size(Bin),
    lists:sum([(
        case sets:is_element(<<C>>, Vowels) of
            true -> (I + 1) * (Size - I);
            false -> 0
        end
    ) || {C, I} <- lists:zip(binary_to_list(Bin), lists:seq(0, Size - 1))]]).