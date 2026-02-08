-module(solution).
-export([final_array/2]).

final_array(A, K) ->
    N = length(A),
    if K rem 2 =:= 0 ->
        A;
    true ->
        lists:map(fun(X) -> -X end, lists:sublist(A, N))
    end.