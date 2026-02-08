-module(solution).
-compile([export_all]).

% max_rotate_function/1
-spec max_rotate_function(Nums :: [integer()]) -> integer().
max_rotate_function(Nums) ->
    N = length(Nums),
    TotalSum = lists:sum(Nums),
    F0 = lists:foldl(fun(X, Acc) -> Acc + X end, 0, lists:zip(Nums, lists:seq(0, N-1))),
    max_rotate_function(Nums, F0, TotalSum, N, 0).

max_rotate_function(_, F, _, 0, Max) -> F;
max_rotate_function(Nums, F, TotalSum, N, Max) ->
    NewF = F + TotalSum - N * hd(Nums),
    max_rotate_function(tl(Nums) ++ [hd(Nums)], NewF, TotalSum, N, max(Max, NewF)).
