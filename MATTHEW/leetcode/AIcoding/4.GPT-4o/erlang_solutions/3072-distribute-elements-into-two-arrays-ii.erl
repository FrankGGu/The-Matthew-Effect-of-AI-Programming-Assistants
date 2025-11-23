-module(solution).
-export([distribute_array/1]).

distribute_array(nums) ->
    Total = lists:sum(nums),
    Half = Total div 2,
    distribute(nums, Half, 0, 0).

distribute([], _, Sum1, Sum2) ->
    abs(Sum1 - Sum2);
distribute([H | T], Target, Sum1, Sum2) ->
    distribute(T, Target, Sum1 + H, Sum2) orelse distribute(T, Target, Sum1, Sum2 + H).