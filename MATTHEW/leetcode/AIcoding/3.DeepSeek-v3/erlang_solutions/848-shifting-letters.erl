-spec shifting_letters(S :: unicode:unicode_binary(), Shifts :: [integer()]) -> unicode:unicode_binary().
shifting_letters(S, Shifts) ->
    List = unicode:characters_to_list(S),
    Sums = lists:reverse(lists:foldl(fun(X, Acc) -> [X + hd(Acc) | Acc] end, [0], lists:reverse(Shifts))),
    Shifted = lists:zipwith(fun(C, Sum) -> (C - $a + Sum) rem 26 + $a end, List, Sums),
    unicode:characters_to_binary(Shifted).