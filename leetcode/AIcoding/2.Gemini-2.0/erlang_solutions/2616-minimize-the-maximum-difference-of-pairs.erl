-module(minimize_max_difference_pairs).
-export([minimize_max_difference/2]).

minimize_max_difference(Nums, P) ->
    SortedNums = lists:sort(Nums),
    minimize_max_difference_helper(SortedNums, P, 0, lists:last(SortedNums) - lists:nth(1, SortedNums)).

minimize_max_difference_helper(Nums, P, Left, Right) ->
    if Left > Right then
        Left
    else
        Mid = (Left + Right) div 2,
        if count_pairs(Nums, Mid) >= P then
            minimize_max_difference_helper(Nums, P, Left, Mid - 1)
        else
            minimize_max_difference_helper(Nums, P, Mid + 1, Right)
        end
    end.

count_pairs(Nums, MaxDiff) ->
    count_pairs_helper(Nums, MaxDiff, 0, 0).

count_pairs_helper([], _MaxDiff, Count, _Index) ->
    Count;
count_pairs_helper([_], _MaxDiff, Count, _Index) ->
    Count;
count_pairs_helper([H1, H2 | T], MaxDiff, Count, Index) ->
    if H2 - H1 <= MaxDiff then
        count_pairs_helper(T, MaxDiff, Count + 1, Index + 2)
    else
        count_pairs_helper([H2 | T], MaxDiff, Count, Index + 1)
    end.