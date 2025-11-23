-module(last_substring).
-export([lexicographical/1]).

lexicographical(S) ->
    N = erlang:length(S),
    I = 0,
    J = 1,
    K = 0,
    lexicographical(S, N, I, J, K).

lexicographical(S, N, I, J, K) ->
    if
        I + K >= N -> 
            erlang:substring(S, I + 1, N - I);
        J + K >= N ->
            erlang:substring(S, J + 1, N - J);
        S[I + K] == S[J + K] ->
            lexicographical(S, N, I, J, K + 1);
        S[I + K] < S[J + K] ->
            lexicographical(S, N, J, J + 1, 0);
        true ->
            lexicographical(S, N, I, J + 1, 0)
    end.