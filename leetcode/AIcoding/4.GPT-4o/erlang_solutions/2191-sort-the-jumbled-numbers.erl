-module(solution).
-export([sort_jumbled/2]).

sort_jumbled(P, A) ->
    Digits = lists:seq(0, 9),
    Mapped = [map_number(P, X) || X <- A],
    Sorted = lists:zip(A, Mapped),
    SortedSorted = lists:sort(fun({_, A}, {_, B}) -> A < B end, Sorted),
    [X || {X, _} <- SortedSorted].

map_number(P, X) ->
    NumString = integer_to_list(X),
    MappedString = lists:map(fun(D) -> lists:nth(D + 1, P) end, [digit_to_integer(C) || C <- NumString]),
    list_to_integer(MappedString).

digit_to_integer(Char) -> 
    Char - $0.