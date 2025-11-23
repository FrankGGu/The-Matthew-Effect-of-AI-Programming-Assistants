-module(solution).
-export([find_even_numbers/0]).

find_even_numbers() ->
    Lists = lists:seq(100, 999),
    EvenNumbers = lists:filter(fun(X) -> X rem 2 == 0 end, Lists),
    ValidNumbers = lists:filter(fun(X) -> unique_digits(X) end, EvenNumbers),
    lists:map(fun(X) -> integer_to_list(X) end, ValidNumbers).

unique_digits(N) ->
    Digits = integer_to_list(N),
    lists:all(fun(D) -> lists:count(Digits, D) == 1 end, Digits).