-module(solution).
-export([difference/1]).

difference(Array) ->
    ElementSum = lists:sum(Array),
    DigitSum = lists:sum(lists:map(fun(X) -> digit_sum(X) end, Array)),
    ElementSum - DigitSum.

digit_sum(X) ->
    lists:sum(integer_to_list(X)).