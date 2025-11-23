-module(solution).
-export([smallest_divisible_digit_product/1]).

smallest_divisible_digit_product(N) ->
    case N of
        0 -> 0;
        _ -> find_smallest(N, 1)
    end.

find_smallest(N, K) ->
    case is_valid(K, N) of
        true -> K;
        false -> find_smallest(N, K + 1)
    end.

is_valid(K, N) ->
    case K rem N =:= 0 of
        false -> false;
        true ->
            Digits = integer_to_list(K),
            lists:all(fun(D) -> D =/= $0 end, Digits) andalso
            lists:all(fun(D) -> N rem (D - $0) =:= 0 end, Digits)
    end.