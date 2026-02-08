-module(solution).
-export([take_k/3]).

take_k(S, K, N) ->
    Left = lists:sublist(S, K),
    Right = lists:sublist(lists:reverse(S), K),
    lists:reverse(Left ++ lists:sublist(S, N - length(Left) - length(Right)) ++ Right).