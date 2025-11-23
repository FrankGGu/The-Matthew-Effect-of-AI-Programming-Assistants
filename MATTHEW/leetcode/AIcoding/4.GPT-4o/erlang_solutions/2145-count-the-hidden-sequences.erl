-module(solution).
-export([count_hidden_sequences/3]).

count_hidden_sequences(N, L, S) ->
    count_hidden_sequences_helper(N, L, S, 0).

count_hidden_sequences_helper(_, 0, S, S) -> 
    1;
count_hidden_sequences_helper(N, L, S, CurrentSum) when CurrentSum < S ->
    lists:sum([count_hidden_sequences_helper(N, L - 1, S, CurrentSum + I) || I <- lists:seq(1, N)]);
count_hidden_sequences_helper(_, _, _, _) -> 
    0.