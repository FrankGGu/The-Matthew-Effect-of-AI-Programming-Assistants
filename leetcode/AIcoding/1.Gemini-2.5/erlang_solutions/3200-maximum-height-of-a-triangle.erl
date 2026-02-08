-module(solution).
-export([maximum_height_of_a_triangle/2]).

maximum_height_of_a_triangle(Red, Blue) ->
    H1 = solve_math(Red, Blue),
    H2 = solve_math(Blue, Red),
    max(H1, H2).

solve_math(C1, C2) ->
    K1_even = floor(math:sqrt(C1)),
    K2_even = floor((-1 + math:sqrt(1 + 4*C2))/2),
    MaxK_even = min(K1_even, K2_even),
    H_even = 2 * MaxK_even,

    K1_odd_candidate = floor(math:sqrt(C1)) - 1,
    K2_odd_candidate = floor((-1 + math:sqrt(1 + 4*C2))/2),

    MaxK_odd_actual = min(K1_odd_candidate, K2_odd_candidate),
    H_odd = if MaxK_odd_actual >= 0 -> 2 * MaxK_odd_actual + 1;
            true -> 0
            end,

    max(H_even, H_odd).