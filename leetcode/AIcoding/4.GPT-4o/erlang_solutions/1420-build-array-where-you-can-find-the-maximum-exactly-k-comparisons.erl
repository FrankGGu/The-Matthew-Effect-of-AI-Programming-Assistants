-module(solution).
-export([build_array/2]).

build_array(N, K) when K > 0, N > 0 ->
    lists:map(fun(X) -> if 
        X =< K -> X; 
        true -> K + (X - K) * 2 
    end end, lists:seq(1, N));
build_array(_, _) ->
    [].