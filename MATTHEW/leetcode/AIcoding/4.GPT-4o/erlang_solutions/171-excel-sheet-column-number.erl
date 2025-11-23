-spec title_to_number(ColumnTitle :: unicode:unicode_binary()) -> integer().
title_to_number(ColumnTitle) ->
    lists:foldl(fun(Char, Acc) ->
                     Acc * 26 + (unicode:char_to_list(Char) - 64)
                 end, 0, ColumnTitle).
