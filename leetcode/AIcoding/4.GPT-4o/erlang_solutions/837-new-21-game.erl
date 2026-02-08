-module(solution).
-export([new21Game/3]).

new21Game(N, K, W) ->
    if
        K == 0 -> 1.0;
        N >= K + W -> 1.0;
        true ->
            P = lists:duplicate(K + W + 1, 0.0),
            P#(0) = 1.0,
            Sum = lists:foldl(fun(X, Acc) ->
                NewAcc = Acc + lists:nth(X, P),
                P#(X) = NewAcc / W,
                if
                    X < K -> NewAcc;
                    true -> NewAcc - lists:nth(X - W, P)
                end
            end, 0.0, lists:seq(1, K + W)),
            lists:foldl(fun(X, Acc) -> Acc + lists:nth(X, P) end, 0.0, lists:seq(K, N))
    end.