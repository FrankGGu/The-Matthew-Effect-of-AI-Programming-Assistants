-module(solution).
-export([smallest_divisible_digit_product/1]).

smallest_divisible_digit_product(N) ->
    case find(N, 1, 9) of
        0 -> -1;
        Result -> Result
    end.

find(N, Start, End) when Start > End -> 0;
find(N, Start, End) ->
    case is_divisible(N, Start) of
        true -> Start;
        false -> find(N, Start + 1, End)
    end.

is_divisible(N, X) ->
    case X of
        0 -> false;
        _ -> N rem X =:= 0
    end.