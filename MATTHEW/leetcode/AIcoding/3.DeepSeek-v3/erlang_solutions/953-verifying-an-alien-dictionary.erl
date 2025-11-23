-spec is_alien_sorted(Words :: [unicode:unicode_binary()], Order :: unicode:unicode_binary()) -> boolean().
is_alien_sorted(Words, Order) ->
    OrderMap = lists:foldl(fun(Char, Acc) -> maps:put(Char, maps:size(Acc), Acc end, #{}, Order),
    check_order(Words, OrderMap).

check_order([], _) -> true;
check_order([_], _) -> true;
check_order([Word1, Word2 | Rest], OrderMap) ->
    case compare_words(Word1, Word2, OrderMap) of
        true -> check_order([Word2 | Rest], OrderMap);
        false -> false
    end.

compare_words(<<>>, <<>>, _) -> true;
compare_words(<<>>, _, _) -> true;
compare_words(_, <<>>, _) -> false;
compare_words(<<C1, Rest1/binary>>, <<C2, Rest2/binary>>, OrderMap) ->
    case {maps:get(C1, OrderMap), maps:get(C2, OrderMap)} of
        {O1, O2} when O1 < O2 -> true;
        {O1, O2} when O1 > O2 -> false;
        _ -> compare_words(Rest1, Rest2, OrderMap)
    end.