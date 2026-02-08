-module(solution).
-export([count_subarrays/1]).

count_subarrays(Array) ->
    Max = lists:max(Array),
    count_subarrays_helper(Array, Max, 0, 0).

count_subarrays_helper([], _, Count, Result) ->
    Result + Count;
count_subarrays_helper([H | T], Max, Count, Result) when H =:= Max ->
    count_subarrays_helper(T, Max, Count + 1, Result);
count_subarrays_helper([H | T], Max, Count, Result) when H /= Max ->
    count_subarrays_helper(T, Max, 0, Result + (Count * (Count + 1) div 2)).