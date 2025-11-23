-spec remove_trailing_zeros(Num :: unicode:unicode_binary()) -> unicode:unicode_binary().
remove_trailing_zeros(Num) ->
    re:replace(Num, "0+$", "", [{return, binary}]).