-spec title_to_number(S :: unicode:unicode_binary()) -> integer().
title_to_number(S) ->
    lists:foldl(fun(Char, Acc) -> Acc * 26 + (Char - $A + 1) end, 0, S).