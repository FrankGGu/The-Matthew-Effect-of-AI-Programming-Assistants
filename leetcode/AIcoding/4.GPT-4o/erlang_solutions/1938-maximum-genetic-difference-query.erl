-module(max_genetic_difference_query).
-export([max_genetic_difference/2]).

max_genetic_difference(Genes, Queries) ->
    N = length(Genes),
    Values = lists:map(fun(X) -> list_to_integer(X) end, Genes),
    QueriesList = lists:map(fun({A, B}) -> {A - 1, B - 1} end, Queries),
    lists:map(fun({A, B}) -> max_genetic_diff(Values, A, B) end, QueriesList).

max_genetic_diff(Values, A, B) ->
    lists:max(lists:map(fun(X) -> bitwise_xor(Values[A], Values[X]) end, lists:seq(0, length(Values) - 1))).

bitwise_xor(A, B) ->
    A bxor B.