-spec find_complement(Num :: integer()) -> integer().
find_complement(Num) ->
    Mask = 1,
    find_complement(Num, Mask).

find_complement(Num, Mask) ->
    case Mask =< Num of
        true -> find_complement(Num, Mask bsl 1);
        false -> (Mask - 1) bxor Num
    end.