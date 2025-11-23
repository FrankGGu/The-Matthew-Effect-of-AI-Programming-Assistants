-module(valid_word_order).
-export([is_valid/2]).

is_valid(WordList, Order) ->
    OrderMap = maps:from_list([{Char, Pos} || {Pos, Char} <- lists:zip(lists:seq(0, length(Order) - 1), Order)]),
    is_valid_words(WordList, OrderMap).

is_valid_words([], _) ->
    true;
is_valid_words([_], _) ->
    true;
is_valid_words([W1, W2 | Rest], OrderMap) ->
    case compare_words(W1, W2, OrderMap) of
        true ->
            is_valid_words([W2 | Rest], OrderMap);
        false ->
            false
    end.

compare_words([], [], _) ->
    true;
compare_words([], _, _) ->
    true;
compare_words(_, [], _) ->
    false;
compare_words([C1 | T1], [C2 | T2], OrderMap) ->
    case maps:get(C1, OrderMap, -1) < maps:get(C2, OrderMap, -1) of
        true ->
            true;
        false ->
            if
                maps:get(C1, OrderMap, -1) == maps:get(C2, OrderMap, -1) ->
                    compare_words(T1, T2, OrderMap);
                true ->
                    false
            end
    end.