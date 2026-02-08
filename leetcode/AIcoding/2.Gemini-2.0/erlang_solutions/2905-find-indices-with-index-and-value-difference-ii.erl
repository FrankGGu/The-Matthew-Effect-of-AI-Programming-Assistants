-module(find_indices_with_index_and_value_difference_ii).
-export([find_indices/3]).

find_indices(Nums, IndexDifference, ValueDifference) ->
    find_indices_helper(Nums, IndexDifference, ValueDifference, 0, length(Nums) - 1, []).

find_indices_helper(Nums, IndexDifference, ValueDifference, I, N, Acc) ->
    if I > N then
        lists:reverse(Acc)
    else
        find_indices_inner(Nums, IndexDifference, ValueDifference, I, I + 1, N, Acc)
    end.

find_indices_inner(Nums, IndexDifference, ValueDifference, I, J, N, Acc) ->
    if J > N then
        find_indices_helper(Nums, IndexDifference, ValueDifference, I + 1, N, Acc)
    else
        if abs(I - J) >= IndexDifference andalso abs(lists:nth(I + 1, Nums) - lists:nth(J + 1, Nums)) >= ValueDifference then
            [I, J]
        else
            find_indices_inner(Nums, IndexDifference, ValueDifference, I, J + 1, N, Acc)
        end
    end.