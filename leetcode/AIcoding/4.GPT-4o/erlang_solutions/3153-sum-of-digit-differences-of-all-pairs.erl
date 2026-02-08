-module(solution).
-export([difference_sum/1]).

difference_sum(N) ->
    Digits = lists:map(fun(X) -> digit_sum(X) end, lists:seq(0, N)),
    Sums = lists:map(fun(X) -> lists:sum(lists:map(fun(Y) -> abs(X - Y) end, Digits)) end, Digits),
    lists:sum(Sums).

digit_sum(Number) ->
    lists:sum(lists:map(fun(X) -> list_to_integer(X) end, string:to_list(integer_to_list(Number)))).