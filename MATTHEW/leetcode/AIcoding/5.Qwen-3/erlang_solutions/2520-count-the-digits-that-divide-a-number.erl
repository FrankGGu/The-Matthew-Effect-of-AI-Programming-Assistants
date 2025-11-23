-module(solution).
-export([digits_divide_number/1]).

digits_divide_number(N) ->
    Digits = integer_to_list(N),
    Count = 0,
    lists:foldl(fun(D, Acc) ->
        Digit = list_to_integer([D]),
        case N rem Digit of
            0 -> Acc + 1;
            _ -> Acc
        end
    end, Count, Digits).