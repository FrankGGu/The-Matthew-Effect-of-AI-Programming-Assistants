-module(solution).
-export([countCompleteSubarrays/1]).

countCompleteSubarrays(Nums) ->
    K = gb_sets:size(gb_sets:from_list(Nums)),
    count_subarrays(K, Nums, Nums, 0).

count_subarrays(_, _, [], Acc) ->
    Acc;
count_subarrays(K, OriginalNums, [H|_T] = CurrentOuterList, Acc) ->
    InnerAcc = count_inner_subarrays(K, CurrentOuterList, gb_sets:new(), 0, 0),
    count_subarrays(K, OriginalNums, tl(CurrentOuterList), Acc + InnerAcc).

count_inner_subarrays(K, [], _, _, InnerAcc) ->
    InnerAcc;
count_inner_subarrays(K, [H|T], CurrentDistinctSet, CurrentDistinctCount, InnerAcc) ->
    {NewSet, NewCount} =
        case gb_sets:is_member(H, CurrentDistinctSet) of
            true -> {CurrentDistinctSet, CurrentDistinctCount};
            false -> {gb_sets:add(H, CurrentDistinctSet), CurrentDistinctCount + 1}
        end,
    NewInnerAcc =
        case NewCount == K of
            true -> InnerAcc + 1;
            false -> InnerAcc
        end,
    count_inner_subarrays(K, T, NewSet, NewCount, NewInnerAcc).