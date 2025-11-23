-module(solution).
-export([final_array/2]).

final_array(A, K) ->
    lists:map(fun(X) -> X * (2#(K) bsr (1#(K) - X)) end, A).