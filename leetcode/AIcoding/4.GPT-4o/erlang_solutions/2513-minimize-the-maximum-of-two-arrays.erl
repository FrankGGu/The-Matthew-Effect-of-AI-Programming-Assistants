-module(solution).
-export([minimize_max/2]).

minimize_max(A, B) ->
    MinMax = fun(N) ->
        lists:foldl(fun(X, Acc) -> min(Acc, (N - X)) end, N, A) +
        lists:foldl(fun(X, Acc) -> min(Acc, (N - X)) end, N, B)
    end,
    binary_search(0, 10^9, MinMax).

binary_search(L, R, F) when L < R ->
    Mid = (L + R) div 2,
    if
        F(Mid) > 0 -> binary_search(Mid + 1, R, F);
        true -> binary_search(L, Mid, F)
    end;
binary_search(L, R, _) -> L.