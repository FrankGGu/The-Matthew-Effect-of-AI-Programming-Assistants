-module(solution).
-export([is_alien_sorted/2]).

is_alien_sorted(Words, Order) ->
    OrderMap = lists:foldl(fun({Char, Index}, Acc) -> maps:put(Char, Index, Acc) end, maps:new(), lists:zip(Order, lists:seq(0, length(Order) - 1))),
    lists:all(fun({A, B}) -> compare_words(A, B, OrderMap) end, lists:zip(Words, tl(Words))).

compare_words(A, B, OrderMap) ->
    case compare_word_lists(list_to_tuple(A), list_to_tuple(B), OrderMap) of
        equal -> true;
        _ -> false
    end.

compare_word_lists({A1, A2}, {B1, B2}, OrderMap) ->
    case maps:get(A1, OrderMap) - maps:get(B1, OrderMap) of
        0 -> compare_word_lists({A2, B2}, {A2, B2}, OrderMap);
        Result -> Result
    end;
compare_word_lists(_, _, _) ->
    equal.

equal -> 0.