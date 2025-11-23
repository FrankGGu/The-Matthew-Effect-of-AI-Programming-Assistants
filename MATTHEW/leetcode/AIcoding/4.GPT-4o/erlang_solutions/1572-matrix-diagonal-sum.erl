-module(solution).
-export([diagonal_sum/1]).

diagonal_sum(Matrix) ->
    Diagonal1 = lists:seq(0, length(Matrix) - 1),
    Diagonal2 = lists:seq(0, length(Matrix) - 1),
    Sum1 = lists:sum(lists:map(fun(I) -> lists:nth(I + 1, Matrix) end, Diagonal1)),
    Sum2 = lists:sum(lists:map(fun(I) -> lists:nth(length(Matrix) - I, Matrix) end, Diagonal2)),
    If = if length(Matrix) rem 2 == 1 -> lists:nth(length(Matrix) div 2 + 1, Matrix) ; true -> 0 end,
    Sum1 + Sum2 - If.