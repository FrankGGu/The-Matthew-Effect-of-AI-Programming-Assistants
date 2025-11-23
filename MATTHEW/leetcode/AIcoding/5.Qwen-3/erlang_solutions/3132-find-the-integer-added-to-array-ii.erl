-module(solution).
-export([added_integer/2]).

added_integer(A, B) ->
    A_sorted = lists:sort(A),
    B_sorted = lists:sort(B),
    lists:nth(1, B_sorted) - lists:nth(1, A_sorted).