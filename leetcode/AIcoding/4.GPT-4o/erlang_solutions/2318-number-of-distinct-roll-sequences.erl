-module(solution).
-export([distinct_roll_sequences/2]).

distinct_roll_sequences(N, K) ->
    M = 1000000007,
    dp(N, K, 1, 0, 0, M).

dp(0, _, _, _, Acc, _) -> 
    Acc;
dp(N, K, Last, LastCount, Acc, M) ->
    NewAcc = (Acc + (K - LastCount) * mod(1 + LastCount, M)) rem M,
    NewLastCount = if LastCount < K then LastCount + 1 else 1 end,
    dp(N - 1, K, Last + 1, NewLastCount, NewAcc, M).