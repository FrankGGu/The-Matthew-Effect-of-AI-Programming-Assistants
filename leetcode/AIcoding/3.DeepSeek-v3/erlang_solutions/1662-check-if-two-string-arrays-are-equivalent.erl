-spec array_strings_are_equal(Word1 :: [unicode:unicode_binary()], Word2 :: [unicode:unicode_binary()]) -> boolean().
array_strings_are_equal(Word1, Word2) ->
    Concatenated1 = lists:concat([binary_to_list(W) || W <- Word1]),
    Concatenated2 = lists:concat([binary_to_list(W) || W <- Word2]),
    Concatenated1 =:= Concatenated2.