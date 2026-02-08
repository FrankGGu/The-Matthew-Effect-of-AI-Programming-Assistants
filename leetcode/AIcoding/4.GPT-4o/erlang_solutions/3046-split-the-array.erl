-module(solution).
-export([split_array/1]).

split_array(Array) ->
    N = length(Array),
    split_array_helper(Array, N, 0).

split_array_helper(_, N, K) when K >= N div 2 -> true;
split_array_helper(Array, N, K) ->
    {Left, Right} = lists.split(K, Array),
    LeftSum = lists:sum(Left),
    RightSum = lists:sum(Right),
    (LeftSum == RightSum orelse split_array_helper(Array, N, K + 1)).