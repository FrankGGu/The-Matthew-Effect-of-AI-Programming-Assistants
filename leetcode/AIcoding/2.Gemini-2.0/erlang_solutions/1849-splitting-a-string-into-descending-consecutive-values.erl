-module(splitting_string).
-export([splitting_into_descending_consecutive_values/1]).

splitting_into_descending_consecutive_values(S) ->
    Len = length(S),
    splitting_into_descending_consecutive_values_helper(S, 0, Len).

splitting_into_descending_consecutive_values_helper(_S, _Start, _Len) ->
    false.

splitting_into_descending_consecutive_values_helper(S, Start, Len) ->
    lists:any(
        fun(I) ->
            First = list_to_integer(lists:sublist(S, Start + 1, I - Start)),
            splitting_into_descending_consecutive_values_recursive(S, I, Len, First)
        end,
        lists:seq(Start + 1, Len - 1)
    ).

splitting_into_descending_consecutive_values_recursive(_S, I, Len, _Prev) when I == Len ->
    true;
splitting_into_descending_consecutive_values_recursive(S, I, Len, Prev) ->
    lists:any(
        fun(J) ->
            Curr = list_to_integer(lists:sublist(S, I + 1, J - I)),
            (Curr == Prev - 1) andalso (splitting_into_descending_consecutive_values_recursive(S, J, Len, Curr))
        end,
        lists:seq(I + 1, Len - 1)
    ).