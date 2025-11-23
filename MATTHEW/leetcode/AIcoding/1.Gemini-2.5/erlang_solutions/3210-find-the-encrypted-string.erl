-module(solution).
-export([getEncryptedString/2]).

getEncryptedString(S, K) ->
    N = length(S),
    [ lists:nth((Idx + K) rem N + 1, S) || Idx <- lists:seq(0, N-1) ].