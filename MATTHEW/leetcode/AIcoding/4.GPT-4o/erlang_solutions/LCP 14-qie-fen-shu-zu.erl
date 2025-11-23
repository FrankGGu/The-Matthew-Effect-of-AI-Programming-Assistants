-module(solution).
-export([split_array/2]).

split_array(A, K) when K > 0, K =< length(A) ->
    split_array(A, K, []).

split_array([], 0, Acc) -> 
    lists:reverse(Acc);
split_array([], K, _) ->
    false;
split_array([H | T], K, Acc) ->
    split_array(T, K - 1, [H | Acc]).