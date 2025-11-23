-module(solution).
-export([spell/2]).

spell(S, K) ->
    Length = length(S),
    N = Length div K,
    lists:sublist(S, 0, N * K).