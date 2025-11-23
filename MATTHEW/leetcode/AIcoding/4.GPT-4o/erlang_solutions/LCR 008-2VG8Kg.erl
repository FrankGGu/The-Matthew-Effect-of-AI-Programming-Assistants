-module(solution).
-export([min_sub_array_len/2]).

min_sub_array_len(Target, nums) ->
    N = length(nums),
    min_sub_array_len(Target, nums, N, 0, 0, infinity).

min_sub_array_len(_, [], _, _, Sum, Min) when Sum >= Target -> Min;
min_sub_array_len(_, [], _, _, _, Min) -> 
    if Min == infinity -> 0; 
       true -> Min 
    end;
min_sub_array_len(Target, [H | T], N, Count, Sum, Min) ->
    NewSum = Sum + H,
    NewCount = Count + 1,
    if NewSum >= Target ->
        min_sub_array_len(Target, T, N, NewCount, NewSum, min(Min, NewCount));
       true ->
        min_sub_array_len(Target, T, N, NewCount, NewSum, Min)
    end.