-module(solution).
-export([find_numbers_with_even_digits/1]).

find_numbers_with_even_digits(Numbers) ->
    lists:foldl(fun(X, Acc) ->
        if
            even_digits(X) -> Acc + 1;
            true -> Acc
        end
    end, 0, Numbers).

even_digits(X) ->
    DigitCount = integer_to_list(X),
    length(DigitCount) rem 2 =:= 0.