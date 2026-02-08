-module(solution).
-export([is_alien_sorted/2]).

is_alien_sorted(Words, Order) ->
    OrderMap = build_order_map(Order),
    check_pairs(Words, OrderMap).

build_order_map(Order) ->
    lists:foldl(fun(Char, AccDict) ->
        dict:store(Char, dict:size(AccDict), AccDict)
    end, dict:new(), Order).

check_pairs([], _) -> true;
check_pairs([_], _) -> true;
check_pairs([Word1, Word2 | Rest], OrderMap) ->
    if
        is_sorted_pair(Word1, Word2, OrderMap) -> check_pairs([Word2 | Rest], OrderMap);
        true -> false
    end.

is_sorted_pair([], _, _) -> true;
is_sorted_pair(_, [], _) -> false;
is_sorted_pair([Char1|Rest1], [Char2|Rest2], OrderMap) ->
    Val1 = dict:fetch(Char1, OrderMap),
    Val2 = dict:fetch(Char2, OrderMap),
    if
        Val1 < Val2 -> true;
        Val1 > Val2 -> false;
        true -> is_sorted_pair(Rest1, Rest2, OrderMap)
    end.