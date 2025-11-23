-module(consecutive_numbers_sum).
-export([consecutive_numbers_sum/1]).

consecutive_numbers_sum(N) ->
    count(N, 1, 0).

count(N, K, Acc) when K * (K - 1) / 2 >= N ->
    Acc.
count(N, K, Acc) ->
    if (N - K * (K - 1) / 2) rem K == 0 ->
        count(N, K + 1, Acc + 1);
    true ->
        count(N, K + 1, Acc)
    end.