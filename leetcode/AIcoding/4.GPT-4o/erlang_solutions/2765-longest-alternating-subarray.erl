-module(solution).
-export([longest_alternating_subarray/1]).

longest_alternating_subarray(List) ->
    longest_alternating_subarray(List, 0, 0, 0).

longest_alternating_subarray([], _, Max, _) -> Max;
longest_alternating_subarray([_], 0, Max, _) -> Max;
longest_alternating_subarray([H | T], 1, Max, Prev) when H =:= Prev + 1 -> 
    longest_alternating_subarray(T, 1, Max + 1, H);
longest_alternating_subarray([H | T], 0, Max, Prev) when H =:= Prev - 1 -> 
    longest_alternating_subarray(T, 1, Max + 1, H);
longest_alternating_subarray([H | T], 0, Max, _) -> 
    longest_alternating_subarray(T, 1, 1, H);
longest_alternating_subarray([H | T], 1, Max, _) -> 
    longest_alternating_subarray(T, 0, 1, H).