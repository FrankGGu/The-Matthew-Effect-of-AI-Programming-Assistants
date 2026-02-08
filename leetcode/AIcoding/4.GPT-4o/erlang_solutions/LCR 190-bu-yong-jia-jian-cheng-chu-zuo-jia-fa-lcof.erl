-module(solution).
-export([encrypt/2]).

encrypt(N, K) ->
    case K rem 2 of
        0 -> 
            lists:map(fun(X) -> X + K end, lists:seq(1, N));
        _ -> 
            lists:map(fun(X) -> X * K end, lists:seq(1, N))
    end.