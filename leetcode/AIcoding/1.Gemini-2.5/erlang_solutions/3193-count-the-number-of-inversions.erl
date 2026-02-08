-module(solution).
-export([inversion_count/1]).

inversion_count(List) ->
    {Count, _SortedList} = merge_sort(List),
    Count.

merge_sort([]) -> {0, []};
merge_sort([H]) -> {0, [H]};
merge_sort(List) ->
    Len = length(List),
    Half = Len div 2,
    {LeftHalf, RightHalf} = lists:split(Half, List),

    {LC, LS} = merge_sort(LeftHalf),
    {RC, RS} = merge_sort(RightHalf),

    {MC, MS} = merge(LS, RS),
    {LC + RC + MC, MS}.

merge(L, R) ->
    LLen = length(L),
    RLen = length(R),
    merge_inner(L, LLen, R, RLen, 0, []).

merge_inner([], _LLen, R, _RLen, Count, Acc) ->
    {Count, lists:reverse(Acc) ++ R};
merge_inner(L, _LLen, [], _RLen, Count, Acc) ->
    {Count, lists:reverse(Acc) ++ L};
merge_inner([LH | LT], LLen, [RH | RT], RLen, Count, Acc) ->
    if LH =< RH ->
        merge_inner(LT, LLen - 1, [RH | RT], RLen, Count, [LH | Acc]);
    true ->
        merge_inner([LH | LT], LLen, RT, RLen - 1, Count + LLen, [RH | Acc])
    end.