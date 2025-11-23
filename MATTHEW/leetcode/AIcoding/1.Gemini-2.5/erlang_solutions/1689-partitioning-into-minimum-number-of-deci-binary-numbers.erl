-spec min_deci_binary(N :: unicode:unicode_binary()) -> integer().
min_deci_binary(N) ->
    CharList = unicode:characters_to_list(N),
    DigitList = lists:map(fun(C) -> C - $0 end, CharList),
    lists:max(DigitList).