-module(solution).
-export([max_score/1]).

max_score(Intervals) ->
    Tuples = [list_to_tuple(I) || I <- Intervals],
    Sorted = lists:sort(fun({_S1, E1, _V1}, {_S2, E2, _V2}) -> E1 =< E2 end, Tuples),

    N = length(Sorted),
    IntervalsArray = array:from_list(Sorted),

    DPArray = array:new([{size, N + 1}, {fixed, true}, {default, 0}]),

    solve_array(IntervalsArray, N, 0, DPArray).

solve_array(_IntervalsArray, N, N, DPArray) ->
    array:get(N, DPArray);
solve_array(IntervalsArray, N, CurrentIdx, DPArray) ->
    {S, _E, V} = array:get(CurrentIdx, IntervalsArray),

    ScoreNotTaken = array:get(CurrentIdx, DPArray),

    P_Idx = find_previous_non_overlapping_index(IntervalsArray, CurrentIdx, S),

    PrevScoreForTaking = if P_Idx >= 0 -> array:get(P_Idx + 1, DPArray);
                           true -> 0
                         end,
    ScoreTaken = V + PrevScoreForTaking,

    NewDPValue = max(ScoreNotTaken, ScoreTaken),
    UpdatedDPArray = array:set(CurrentIdx + 1, NewDPValue, DPArray),

    solve_array(IntervalsArray, N, CurrentIdx + 1, UpdatedDPArray).

find_previous_non_overlapping_index(IntervalsArray, CurrentIdx, CurrentIntervalStart) ->
    find_previous_non_overlapping_index_bs(IntervalsArray, 0, CurrentIdx - 1, CurrentIntervalStart, -1).

find_previous_non_overlapping_index_bs(_IntervalsArray, Low, High, _TargetStart, BestIdx) when Low > High ->
    BestIdx;
find_previous_non_overlapping_index_bs(IntervalsArray, Low, High, TargetStart, BestIdx) ->
    Mid = Low + (High - Low) div 2,
    {_S, E, _V} = array:get(Mid, IntervalsArray),

    if E =< TargetStart ->
        find_previous_non_overlapping_index_bs(IntervalsArray, Mid + 1, High, TargetStart, Mid);
    else
        find_previous_non_overlapping_index_bs(IntervalsArray, Low, Mid - 1, TargetStart, BestIdx)
    end.