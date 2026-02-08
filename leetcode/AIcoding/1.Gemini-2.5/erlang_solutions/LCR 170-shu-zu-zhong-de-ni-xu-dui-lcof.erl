-module(solution).
-export([reversePairs/1]).

reversePairs(Nums) ->
    {Count, _SortedList} = merge_sort_and_count(Nums),
    Count.

merge_sort_and_count(List) ->
    case List of
        [] -> {0, []};
        [_] -> {0, List};
        _ ->
            Len = length(List),
            Mid = Len div 2,
            {Left, Right} = lists:split(Mid, List),

            {CountL, SortedL} = merge_sort_and_count(Left),
            {CountR, SortedR} = merge_sort_and_count(Right),

            CountMerge = count_pairs_in_merge(SortedL, SortedR),
            MergedSorted = merge_lists(SortedL, SortedR),

            {CountL + CountR + CountMerge, MergedSorted}
    end.

count_pairs_in_merge(L, R) ->
    count_pairs_in_merge_loop(L, R, 0).

count_pairs_in_merge_loop([], _R_current_ptr, Acc) -> Acc;
count_pairs_in_merge_loop([HL | TL], R_current_ptr, Acc) ->
    % R_current_ptr is the 'j' pointer for the right list.
    % It only moves forward across calls for different HL.
    {NewR_current_ptr, CountForHL} = advance_r_and_count(HL, R_current_ptr, 0),
    count_pairs_in_merge_loop(TL, NewR_current_ptr, Acc + CountForHL).

advance_r_and_count(_HL, [], Acc) -> {[], Acc};
advance_r_and_count(HL, [HR | TR], Acc) ->
    % The problem states nums[i] > 2 * nums[j].
    % Erlang integers handle arbitrary precision, so overflow is not an issue for 2 * HR.
    if HL > 2 * HR ->
        advance_r_and_count(HL, TR, Acc + 1);
    true ->
        {[HR | TR], Acc}
    end.

merge_lists(L, R) ->
    merge_lists_loop(L, R, []).

merge_lists_loop([], [], Acc) -> lists:reverse(Acc);
merge_lists_loop([], R, Acc) -> lists:reverse(R ++ Acc);
merge_lists_loop(L, [], Acc) -> lists:reverse(L ++ Acc);
merge_lists_loop([HL | TL], [HR | TR], Acc) ->
    if HL =< HR ->
        merge_lists_loop(TL, [HR | TR], [HL | Acc]);
    true ->
        merge_lists_loop([HL | TL], TR, [HR | Acc])
    end.