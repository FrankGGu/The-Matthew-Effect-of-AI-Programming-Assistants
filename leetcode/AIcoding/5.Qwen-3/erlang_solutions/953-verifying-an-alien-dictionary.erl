-module(alien_dictionary).
-export([is_alien_sorted/2]).

is_alien_sorted(WordList, Order) ->
    OrderMap = maps:from_list([{Char, Pos} || {Pos, Char} <- lists:zip(lists:seq(1, length(Order)), Order)]),
    is_alien_sorted(WordList, OrderMap).

is_alien_sorted([], _) ->
    true;
is_alien_sorted([_], _) ->
    true;
is_alien_sorted([W1, W2 | Rest], OrderMap) ->
    case compare_words(W1, W2, OrderMap) of
        true -> is_alien_sorted([W2 | Rest], OrderMap);
        false -> false
    end.

compare_words([], [], _) ->
    true;
compare_words([], _, _) ->
    true;
compare_words(_, [], _) ->
    false;
compare_words([C1 | T1], [C2 | T2], OrderMap) ->
    case maps:get(C1, OrderMap, -1) < maps:get(C2, OrderMap, -1) of
        true -> true;
        false ->
            case maps:get(C1, OrderMap, -1) > maps:get(C2, OrderMap, -1) of
                true -> false;
                false -> compare_words(T1, T2, OrderMap)
            end
    end.