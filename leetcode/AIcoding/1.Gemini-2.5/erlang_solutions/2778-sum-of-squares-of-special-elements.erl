-module(solution).
-export([sum_of_squares_of_special_elements/1]).

-spec sum_of_squares_of_special_elements(Nums :: [integer()]) -> integer().
sum_of_squares_of_special_elements(Nums) ->
    N = length(Nums),
    sum_special_elements_optimized(Nums, N, 0, 0).

sum_special_elements_optimized([], _N, _I, Acc) ->
    Acc;
sum_special_elements_optimized([H|T], N, I, Acc) ->
    Divisor = I + 1,
    NewAcc =
        case N rem Divisor of
            0 ->
                Acc + (H * H);
            _ ->
                Acc
        end,
    sum_special_elements_optimized(T, N, I + 1, NewAcc).