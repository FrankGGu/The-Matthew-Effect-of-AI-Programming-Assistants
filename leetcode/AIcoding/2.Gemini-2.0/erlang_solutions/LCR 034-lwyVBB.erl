-module(alien_dictionary).
-export([is_alien_sorted/2]).

is_alien_sorted(Words, Order) ->
    OrderMap = lists:foldl(fun({Char, Index}, Acc) -> maps:put(Char, Index, Acc) end, #{}, lists:zip(Order, lists:seq(1, length(Order)))),
    lists:all(fun({W1, W2}) -> is_sorted(W1, W2, OrderMap) end, lists:zip(Words, tl(Words))).

is_sorted([], _, _) -> true;
is_sorted(_, [], _) -> false;
is_sorted([], [], _) -> true;
is_sorted([C1|R1], [C2|R2], OrderMap) ->
    case maps:get(C1, OrderMap) < maps:get(C2, OrderMap) of
        true -> true;
        false ->
            case maps:get(C1, OrderMap) > maps:get(C2, OrderMap) of
                true -> false;
                false -> is_sorted(R1, R2, OrderMap)
            end
    end.