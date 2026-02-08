-module(solution).
-export([maximum_sum_of_almost_unique_subarray/3]).

maximum_sum_of_almost_unique_subarray(Nums, M, K) ->
    Len = length(Nums),
    if Len < K ->
        0;
    true ->
        InitialWindow = lists:sublist(Nums, K),
        {InitialSum, InitialCounts} = init_window(InitialWindow),

        InitialMaxSum = 
            if maps:size(InitialCounts) >= M ->
                InitialSum;
            true ->
                0
            end,

        InitialWindowQueue = lists:foldl(fun(E, Q) -> queue:in(E, Q) end, queue:new(), InitialWindow),

        sliding_window(lists:nthtail(Nums, K), InitialWindowQueue, InitialSum, InitialCounts, InitialMaxSum, M, K)
    end.

init_window(Window) ->
    lists:foldl(
        fun(Num, {Counts, Sum}) ->
            {maps:update_with(Num, fun(Count) -> Count + 1 end, 1, Counts), Sum + Num}
        end,
        {#{}, 0},
        Window
    ).

sliding_window([], _WindowQueue, _CurrentSum, _CurrentCounts, MaxSumAcc, _M, _K) ->
    MaxSumAcc;
sliding_window([NewNum | RestNewNums], WindowQueue, CurrentSum, CurrentCounts, MaxSumAcc, M, K) ->
    {value {OldNum, RestWindowQueue}} = queue:out(WindowQueue),

    UpdatedCounts1 = maps:update_with(OldNum, fun(Count) -> Count - 1 end, CurrentCounts),
    FinalCountsAfterOld = 
        case maps:get(OldNum, UpdatedCounts1) of
            0 -> maps:remove(OldNum, UpdatedCounts1);
            _ -> UpdatedCounts1
        end,
    NewSumAfterOld = CurrentSum - OldNum,

    NewWindowQueue = queue:in(NewNum, RestWindowQueue),

    FinalCountsAfterNew = maps:update_with(NewNum, fun(Count) -> Count + 1 end, 1, FinalCountsAfterOld),
    NewSumAfterNew = NewSumAfterOld + NewNum,

    NewMaxSumAcc = 
        if maps:size(FinalCountsAfterNew) >= M ->
            max(MaxSumAcc, NewSumAfterNew);
        true ->
            MaxSumAcc
        end,

    sliding_window(RestNewNums, NewWindowQueue, NewSumAfterNew, FinalCountsAfterNew, NewMaxSumAcc, M, K).