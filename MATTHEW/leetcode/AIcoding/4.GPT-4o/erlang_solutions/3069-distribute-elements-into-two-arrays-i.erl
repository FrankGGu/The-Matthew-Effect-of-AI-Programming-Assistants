-module(solution).
-export([distribute_array/1]).

distribute_array(Array) ->
    N = length(Array),
    K = div(N, 2),
    {A, B} = lists:split(K, lists:sort(Array)),
    [A, B].