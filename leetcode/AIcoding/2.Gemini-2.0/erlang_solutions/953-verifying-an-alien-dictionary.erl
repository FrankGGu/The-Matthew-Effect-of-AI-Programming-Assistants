-module(alien_dictionary).
-export([is_alien_sorted/2]).

is_alien_sorted(Words, Order) ->
    OrderMap = lists:zip(Order, lists:seq(1, length(Order))),
    is_sorted(Words, OrderMap).

is_sorted([], _) ->
    true;
is_sorted([_], _) ->
    true;
is_sorted([W1, W2 | Rest], OrderMap) ->
    case compare_words(W1, W2, OrderMap) of
        true ->
            is_sorted([W2 | Rest], OrderMap);
        false ->
            false
    end.

compare_words([], [], _) ->
    true;
compare_words([], _, _) ->
    true;
compare_words(_, [], _) ->
    false;
compare_words([C1 | R1], [C2 | R2], OrderMap) ->
    V1 = proplists:get_value(C1, OrderMap),
    V2 = proplists:get_value(C2, OrderMap),
    case V1 < V2 of
        true ->
            true;
        false ->
            case V1 > V2 of
                true ->
                    false;
                false ->
                    compare_words(R1, R2, OrderMap)
            end
    end.