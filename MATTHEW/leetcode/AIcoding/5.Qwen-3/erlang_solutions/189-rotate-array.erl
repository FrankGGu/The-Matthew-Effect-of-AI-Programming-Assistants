-module(rotate_array).
-export([rotate/2]).

rotate(Remove, Array) ->
    N = length(Array),
    K = Remove rem N,
    rotate(K, Array).

rotate(0, Array) ->
    Array;
rotate(K, Array) ->
    L = length(Array),
    {Left, Right} = lists:split(L - K, Array),
    lists:append(Right, Left).