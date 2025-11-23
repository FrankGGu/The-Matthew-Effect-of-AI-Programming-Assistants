-module(solution).
-export([pizza_with_3n_slices/1]).

max_val(Slices, K) ->
    Len = length(Slices),
    % DPTable is an array where each element DPTable[i] is an array representing dp[i][j] for j=0..K
    % dp[i] corresponds to considering slices Slices[0]...Slices[i-1]
    DPTable = array:new({size, Len + 1}),

    % Base case: dp[0] (0 slices considered)
    InitialRowArr = array:new({size, K + 1}, {default, 0}), % All 0s for j=0..K
    DPTable1 = array:set(0, InitialRowArr, DPTable),

    % Base case: dp[1] (1 slice considered: Slices[0])
    Row1Arr = array:new({size, K + 1}, {default, 0}),
    % If we pick 1 slice, and Slices[0] is the only one considered, max sum is Slices[0]
    Row1Arr1 = array:set(1, hd(Slices), Row1Arr), % dp[1][1] = Slices[0]
    DPTable2 = array:set(1, Row1Arr1, DPTable1),

    % Fill the DP table iteratively
    max_val_loop(1, Len - 1, Slices, K, DPTable2).

max_val_loop(SliceIdx, MaxSliceIdx, Slices, K, DPTable) ->
    if SliceIdx > MaxSliceIdx ->
        % After processing all slices up to Slices[MaxSliceIdx],
        % the result is dp[MaxSliceIdx + 1][K]
        array:get(K, array:get(MaxSliceIdx + 1, DPTable));
    else
        CurrentSliceVal = lists:nth(SliceIdx + 1, Slices), % Get Slices[SliceIdx] (1-indexed lists:nth)
        PrevDPArr = array:get(SliceIdx, DPTable),         % Corresponds to dp[SliceIdx] (considering Slices[0]...Slices[SliceIdx-1])
        PrevPrevDPArr = array:get(SliceIdx - 1, DPTable), % Corresponds to dp[SliceIdx - 1] (considering Slices[0]...Slices[SliceIdx-2])

        CurrentRowArr = array:new({size, K + 1}, {default, 0}),
        NewCurrentRowArr = fill_row_arr(1, K, CurrentSliceVal, PrevDPArr, PrevPrevDPArr, CurrentRowArr),

        % Store the computed row for dp[SliceIdx + 1] (considering Slices[0]...Slices[SliceIdx])
        NewDPTable = array:set(SliceIdx + 1, NewCurrentRowArr, DPTable),
        max_val_loop(SliceIdx + 1, MaxSliceIdx, Slices, K, NewDPTable)
    end.

fill_row_arr(J, MaxJ, CurrentSliceVal, PrevDPArr, PrevPrevDPArr, AccRowArr) ->
    if J > MaxJ ->
        AccRowArr;
    else
        % Option 1: Don't pick CurrentSliceVal. Value comes from dp[i-1][j]
        Val1 = array:get(J, PrevDPArr),
        % Option 2: Pick CurrentSliceVal. Value comes from dp[i-2][j-1] + CurrentSliceVal
        Val2 = if J > 0 -> array:get(J - 1, PrevPrevDPArr) + CurrentSliceVal;
                  true -> 0 % Cannot pick 0 slices if J=0, but J starts from 1 here
               end,

        NewAccRowArr = array:set(J, max(Val1, Val2), AccRowArr),
        fill_row_arr(J + 1, MaxJ, CurrentSliceVal, PrevDPArr, PrevPrevDPArr, NewAccRowArr)
    end.

pizza_with_3n_slices(Slices) ->
    Len = length(Slices),
    K = Len div 3,

    % Case 1: Exclude the last slice. Consider slices Slices[0] to Slices[Len-2].
    % lists:sublist(List, Start, Length) uses 1-based indexing for Start.
    Slices1 = lists:sublist(Slices, 1, Len - 1),
    Result1 = max_val(Slices1, K),

    % Case 2: Exclude the first slice. Consider slices Slices[1] to Slices[Len-1].
    Slices2 = lists:sublist(Slices, 2, Len - 1),
    Result2 = max_val(Slices2, K),

    max(Result1, Result2).