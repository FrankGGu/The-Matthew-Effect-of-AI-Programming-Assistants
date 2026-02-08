-module(minimum_bitwise_or).
-export([solve/2]).

solve(N, K) ->
    solve(N, K, 0, 1).

solve(N, K, Acc, Pow) when Acc + Pow > K ->
    solve(N, K, Acc, Pow * 2);

solve(N, K, Acc, Pow) when N =:= 0 ->
    Acc;

solve(N, K, Acc, Pow) ->
    if Acc + Pow <= K then
        solve(N - 1, K, Acc + Pow, Pow * 2)
    else
        solve(N - 1, K, Acc, Pow * 2)
    end.