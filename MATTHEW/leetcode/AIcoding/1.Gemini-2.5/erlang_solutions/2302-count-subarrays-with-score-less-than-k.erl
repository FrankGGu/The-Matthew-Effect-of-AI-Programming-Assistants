-module(solution).
-export([countSubarrays/2]).

-spec countSubarrays(Nums :: [integer()], K :: integer()) -> integer().
countSubarrays(Nums, K) ->
    Arr = array:from_list(Nums),
    Len = array:size(Arr),
    countSubarrays_array_sliding(Arr, Len, K, 0, 0, 0, 0).

countSubarrays_array_sliding(Arr, Len, K, LeftIdx, RightIdx, CurrentSum, TotalCount) ->
    if
        RightIdx < Len ->
            RightVal = array:get(RightIdx, Arr),
            NewCurrentSum = CurrentSum + RightVal,

            {FinalLeftIdx, FinalCurrentSum} = 
                adjust_window_from_left_array(Arr, K, LeftIdx, RightIdx, NewCurrentSum),

            WindowLength = RightIdx - FinalLeftIdx + 1,
            NewTotalCount = TotalCount + WindowLength,

            countSubarrays_array_sliding(Arr, Len, K, FinalLeftIdx, RightIdx + 1, FinalCurrentSum, NewTotalCount);
        true ->
            TotalCount
    end.

adjust_window_from_left_array(Arr, K, LeftIdx, RightIdx, CurrentSum) ->
    WindowLength = RightIdx - LeftIdx + 1,
    if
        WindowLength > 0 andalso CurrentSum * WindowLength >= K ->
            LeftVal = array:get(LeftIdx, Arr),
            adjust_window_from_left_array(Arr, K, LeftIdx + 1, RightIdx, CurrentSum - LeftVal);
        true ->
            {LeftIdx, CurrentSum}
    end.