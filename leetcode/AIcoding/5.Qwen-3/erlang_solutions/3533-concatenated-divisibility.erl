-module(solution).
-export([is_divisible/2]).

is_divisible(Numbers, divisor) ->
    is_divisible(Numbers, divisor, 1).

is_divisible([], _Divisor, _Acc) ->
    true;
is_divisible([N | T], Divisor, Acc) ->
    Concat = Acc * 1000000000 + N,
    case Concat rem Divisor of
        0 -> is_divisible(T, Divisor, 1);
        _ -> false
    end.