-module(solution).
-export([digit_count/1]).

digit_count(N) ->
    Digits = integer_to_list(N),
    Count = length(Digits),
    DigitSum = lists:sum(lists:map(fun(X) -> list_to_integer([X]) end, Digits)),
    Count == DigitSum.