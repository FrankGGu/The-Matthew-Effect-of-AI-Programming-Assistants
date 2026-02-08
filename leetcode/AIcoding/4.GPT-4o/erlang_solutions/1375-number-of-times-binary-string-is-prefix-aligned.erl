-module(solution).
-export([prefix_aligned/1]).

prefix_aligned(BinaryString) ->
    binary_to_list(BinaryString)
    |> prefix_aligned_helper(0, 0).

prefix_aligned_helper([], _, Count) ->
    Count;
prefix_aligned_helper([H | T], Ones, Count) ->
    NewOnes = Ones + (if H == $1 -> 1; true -> 0 end),
    NewCount = Count + (if NewOnes == length(T) + 1 -> 1; true -> 0 end),
    prefix_aligned_helper(T, NewOnes, NewCount).