-module(solution).
-export([sliding_subarray_beauty/3]).

update_freq_array(FreqArray, Val, Change) ->
    Index = Val + 50,
    CurrentCount = array:get(Index, FreqArray),
    NewCount = CurrentCount + Change,
    array:set(Index, NewCount, FreqArray).

find_xth_smallest_array(FreqArray, X) ->
    find_xth_smallest_array_recursive(FreqArray, X, 0, 0).

find_xth_smallest_array_recursive(FreqArray, TargetX, CurrentValIndex, AccCount) when CurrentValIndex =< 100 ->
    CountAtCurrentVal = array:get(CurrentValIndex, FreqArray),
    if AccCount + CountAtCurrentVal >= TargetX ->
        CurrentValIndex - 50;
    true ->
        find_xth_smallest_array_recursive(FreqArray, TargetX, CurrentValIndex + 1, AccCount + CountAtCurrentVal)
    end;
find_xth_smallest_array_recursive(_FreqArray, _TargetX, _CurrentValIndex, _AccCount) ->
    error(xth_smallest_not_found).

beauty_rule(Val) when Val < 0 -> Val;
beauty_rule(_Val) -> 0.

sliding_subarray_beauty(NumsList, K, X) ->
    Nums = array:from_list(NumsList),
    N = array:size(Nums),

    InitialFreqArray = array:new(101, {default, 0}),

    FirstWindowFreqArray = lists:foldl(fun(Idx, AccFreqArray) ->
                                            Num = array:get(Idx, Nums),
                                            update_freq_array(AccFreqArray, Num, 1)
                                    end, InitialFreqArray, lists:seq(0, K - 1)),

    FirstBeauty = find_xth_smallest_array(FirstWindowFreqArray, X),
    BeautyList = [beauty_rule(FirstBeauty)],

    slide_window_indexed_array(Nums, K, X, K, FirstWindowFreqArray, BeautyList, N).

slide_window_indexed_array(Nums, K, X, CurrentIdx, CurrentFreqArray, AccBeautyList, N) when CurrentIdx < N ->
    NumToRemove = array:get(CurrentIdx - K, Nums),
    NumToAdd = array:get(CurrentIdx, Nums),

    UpdatedFreq1 = update_freq_array(CurrentFreqArray, NumToRemove, -1),
    UpdatedFreq2 = update_freq_array(UpdatedFreq1, NumToAdd, 1),

    CurrentBeauty = find_xth_smallest_array(UpdatedFreq2, X),
    NewAccBeautyList = [beauty_rule(CurrentBeauty) | AccBeautyList],

    slide_window_indexed_array(Nums, K, X, CurrentIdx + 1, UpdatedFreq2, NewAccBeautyList, N);
slide_window_indexed_array(_Nums, _K, _X, _CurrentIdx, _CurrentFreqArray, AccBeautyList, _N) ->
    lists:reverse(AccBeautyList).