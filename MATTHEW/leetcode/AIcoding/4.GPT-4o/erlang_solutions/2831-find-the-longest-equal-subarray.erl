-module(solution).
-export([longest_equal_subarray/1]).

longest_equal_subarray(List) ->
    longest_equal_subarray(List, 0, 0, 0).

longest_equal_subarray([], _, Max, _) -> 
    Max;
longest_equal_subarray([H | T], Count, Max, Prev) ->
    NewCount = if H == Prev -> Count + 1; true -> 1 end,
    NewMax = max(Max, NewCount),
    longest_equal_subarray(T, NewCount, NewMax, H).