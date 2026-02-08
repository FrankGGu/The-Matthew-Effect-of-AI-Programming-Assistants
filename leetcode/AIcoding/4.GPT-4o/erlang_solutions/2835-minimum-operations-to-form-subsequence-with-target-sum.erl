-module(solution).
-export([min_operations/2]).

min_operations(Target, nums) ->
    SortedNums = lists:sort(nums),
    min_ops(SortedNums, Target, 0).

min_ops([], _, Count) -> Count;
min_ops([H | T], Target, Count) ->
    if
        Target == 0 -> 
            Count;
        Target < H -> 
            min_ops(T, Target, Count + 1);
        true -> 
            min_ops(T, Target - H, Count)
    end.