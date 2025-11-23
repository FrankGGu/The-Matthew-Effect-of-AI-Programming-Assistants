-module(solution).
-export([sum_of_numbers_with_units_digit_k/2]).

sum_of_numbers_with_units_digit_k(0, _K) ->
    0;
sum_of_numbers_with_units_digit_k(Num, K) ->
    find_min_n(Num, K, 1).

find_min_n(Num, K, N) when N =< 10 ->
    Remainder = Num - N * K,
    if
        Remainder >= 0 andalso Remainder rem 10 == 0 ->
            N;
        true ->
            find_min_n(Num, K, N + 1)
    end;
find_min_n(_Num, _K, _N) ->
    -1.