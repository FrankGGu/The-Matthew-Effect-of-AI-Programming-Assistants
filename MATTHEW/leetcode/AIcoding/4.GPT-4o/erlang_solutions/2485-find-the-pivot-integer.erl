-module(solution).
-export([pivot_integer/1]).

pivot_integer(N) ->
    TotalSum = (N * (N + 1)) div 2,
    Pivot = lists:foldl(fun(X, Acc) ->
        if
            Acc + X * 2 =:= TotalSum -> X;
            true -> Acc
        end
    end, -1, lists:seq(1, N)).