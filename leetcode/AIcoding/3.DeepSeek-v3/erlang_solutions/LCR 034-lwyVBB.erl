-spec is_alien_sorted(Words :: [unicode:unicode_binary()], Order :: unicode:unicode_binary()) -> boolean().
is_alien_sorted(Words, Order) ->
    OrderMap = lists:foldl(fun(Char, Acc) -> maps:put(Char, maps:size(Acc), Acc) end, #{}, Order),
    check_order(Words, OrderMap).

check_order([], _) -> true;
check_order([_], _) -> true;
check_order([Word1, Word2 | Rest], OrderMap) ->
    case compare(Word1, Word2, OrderMap) of
        true -> check_order([Word2 | Rest], OrderMap);
        false -> false
    end.

compare(<<>>, <<>>, _) -> true;
compare(<<>>, _, _) -> true;
compare(_, <<>>, _) -> false;
compare(<<C1, Rest1/binary>>, <<C2, Rest2/binary>>, OrderMap) ->
    case {maps:get(C1, OrderMap), maps:get(C2, OrderMap)} of
        {V1, V2} when V1 < V2 -> true;
        {V1, V2} when V1 > V2 -> false;
        _ -> compare(Rest1, Rest2, OrderMap)
    end.