-spec halves_are_alike(S :: unicode:unicode_binary()) -> boolean().
halves_are_alike(S) ->
    Vowels = sets:from_list("aeiouAEIOU"),
    Length = byte_size(S),
    Half = Length div 2,
    FirstHalf = binary_part(S, 0, Half),
    SecondHalf = binary_part(S, Half, Half),
    Count1 = count_vowels(FirstHalf, Vowels),
    Count2 = count_vowels(SecondHalf, Vowels),
    Count1 =:= Count2.

count_vowels(Bin, Vowels) ->
    binary:matches(Bin, Vowels).