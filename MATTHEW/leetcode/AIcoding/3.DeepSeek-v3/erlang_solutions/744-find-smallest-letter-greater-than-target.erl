-spec next_greatest_letter(Letters :: [char()], Target :: char()) -> char().
next_greatest_letter(Letters, Target) ->
    lists:min([X || X <- Letters, X > Target] ++ [hd(Letters)]).