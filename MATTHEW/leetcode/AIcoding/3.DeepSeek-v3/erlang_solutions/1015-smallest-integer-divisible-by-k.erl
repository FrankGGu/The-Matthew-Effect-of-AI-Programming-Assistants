-spec smallest_repunit_div_by_k(K :: integer()) -> integer().
smallest_repunit_div_by_k(K) ->
    case K rem 2 =:= 0 orelse K rem 5 =:= 0 of
        true -> -1;
        false ->
            N = 1,
            Len = 1,
            Rem = N rem K,
            smallest_repunit_div_by_k(K, Len + 1, Rem)
    end.

smallest_repunit_div_by_k(K, Len, Rem) ->
    NewRem = (Rem * 10 + 1) rem K,
    case NewRem of
        0 -> Len;
        _ -> smallest_repunit_div_by_k(K, Len + 1, NewRem)
    end.