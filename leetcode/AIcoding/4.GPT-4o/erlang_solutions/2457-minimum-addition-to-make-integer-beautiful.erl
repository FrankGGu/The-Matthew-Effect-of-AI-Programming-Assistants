-module(solution).
-export([make_integer_beautiful/2]).

make_integer_beautiful(N, K) ->
    case is_beautiful(N, K) of
        true -> 0;
        false -> find_beautiful(N, K, 0)
    end.

is_beautiful(N, K) ->
    sum_digits(N) =< K.

sum_digits(0) -> 0;
sum_digits(X) -> X rem 10 + sum_digits(X div 10).

find_beautiful(N, K, Acc) ->
    case is_beautiful(N + Acc, K) of
        true -> Acc;
        false -> find_beautiful(N, K, Acc + 1)
    end.