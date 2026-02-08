-module(solution).
-export([divide_array/2]).

divide_array(N, K) when N rem K == 0 ->
    N div K;
divide_array(_, _) ->
    -1.