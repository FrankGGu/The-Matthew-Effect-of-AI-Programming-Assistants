-module(solution).
-export([max_frequency/2]).

max_frequency(Nums, K) ->
    SortedNums = lists:sort(Nums),
    max_frequency_loop(K, SortedNums, SortedNums, 0, 0, 0, 0).

max_frequency_loop(_K, _LeftList, [], _LeftIndex, _RightIndex, _CurrentSum, MaxFreq) ->
    MaxFreq;
max_frequency_loop(K, LeftList, [ElementRight | RestRight], LeftIndex, RightIndex, CurrentSum, MaxFreq) ->
    NewCurrentSum = CurrentSum + ElementRight,
    NewRightIndex = RightIndex + 1,

    ShrinkLoop = fun Shrink(LList, CSum, LIdx) ->
        WindowSize = NewRightIndex - LIdx,
        Cost = (ElementRight * WindowSize) - CSum,
        if Cost =< K ->
            {LList, CSum, LIdx};
        else
            [ElementLeft | RestLeft] = LList,
            Shrink(RestLeft, CSum - ElementLeft, LIdx + 1)
        end
    end,

    {FinalLeftList, FinalCurrentSum, FinalLeftIndex} = ShrinkLoop(LeftList, NewCurrentSum, LeftIndex),
    NewMaxFreq = max(MaxFreq, NewRightIndex - FinalLeftIndex),

    max_frequency_loop(K, FinalLeftList, RestRight, FinalLeftIndex, NewRightIndex, FinalCurrentSum, NewMaxFreq).