-module(solution).
-export([fair_candy_swap/2]).

fair_candy_swap(A, B) ->
    Sum = lists:sum(A) + lists:sum(B),
    Target = Sum div 2,
    SetB = sets:from_list(B),
    [X, Y] || X <- A, Y = Target - (lists:sum(A) - X), sets:is_element(Y, SetB).