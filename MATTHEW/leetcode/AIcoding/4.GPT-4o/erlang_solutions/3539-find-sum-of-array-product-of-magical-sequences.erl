-module(solution).
-export([sum_of_magical_sequences/1]).

sum_of_magical_sequences(N) ->
    lists:foldl(fun(X, Acc) -> Acc + (X * (N - X + 1)) end, 0, lists:seq(1, N)) rem (10^9 + 7).