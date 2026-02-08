-module(solution).
-export([reverse_pairs/1]).

reverse_pairs(Nums) ->
    element(2, merge_sort_and_count(Nums)).

merge_sort_and_count(List) ->
    Len = length(List),
    if Len =< 1 ->
        {List, 0};
    else
        Mid = Len div 2,
        {LeftHalf, RightHalf} = lists:split(Mid, List),
        {SortedLeft, CountLeft} = merge_sort_and_count(LeftHalf),
        {SortedRight, CountRight} = merge_sort_and_count(RightHalf),
        CountMerge = count_pairs_between(SortedLeft, SortedRight),
        MergedList = merge(SortedLeft, SortedRight),
        {MergedList, CountLeft + CountRight + CountMerge}
    end.

count_pairs_between(L1, L2) ->
    count_pairs_between_helper(L1, L2, 0).

count_pairs_between_helper([], _L2_ptr, Acc) ->
    Acc;
count_pairs_between_helper([H1|T1], L2_ptr, Acc) ->
    {NewL2_ptr, NumValid} = find_valid_elements(H1, L2_ptr, 0),
    count_pairs_between_helper(T1, NewL2_ptr, Acc + NumValid).

find_valid_elements(_Val, [], Acc) ->
    {[], Acc};
find_valid_elements(Val, [H2|T2], Acc) ->
    if Val > 2 * H2 ->
        find_valid_elements(Val, T2, Acc + 1);
    else
        {[H2|T2], Acc}
    end.

merge(L1, L2) ->
    do_merge(L1, L2, []).

do_merge([], L2, Acc) ->
    lists:reverse(Acc) ++ L2;
do_merge(L1, [], Acc) ->
    lists:reverse(Acc) ++ L1;
do_merge([H1|T1], [H2|T2], Acc) ->
    if H1 =< H2 ->
        do_merge(T1, [H2|T2], [H1|Acc]);
    else
        do_merge([H1|T1], T2, [H2|Acc])
    end.