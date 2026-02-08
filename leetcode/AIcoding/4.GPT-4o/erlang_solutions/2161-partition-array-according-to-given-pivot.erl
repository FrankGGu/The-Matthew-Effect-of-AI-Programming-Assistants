-module(solution).
-export([pivot_array/2]).

pivot_array(A, P) ->
    lists:filter(fun(X) -> X < P end, A) ++ 
    lists:filter(fun(X) -> X =:= P end, A) ++ 
    lists:filter(fun(X) -> X > P end, A).