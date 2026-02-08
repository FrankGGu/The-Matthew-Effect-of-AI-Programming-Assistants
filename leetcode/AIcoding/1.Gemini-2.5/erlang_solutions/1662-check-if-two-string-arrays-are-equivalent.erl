-spec is_equivalent(Word1 :: [binary()], Word2 :: [binary()]) -> boolean().
is_equivalent(Word1, Word2) ->
    lists:append(Word1) == lists:append(Word2).