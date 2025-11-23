-module(solution).
-export([ways_to_partition/2]).

ways_to_partition(Nums, K) ->
    N = length(Nums),
    NumsArray = array:from_list(Nums),
    PrefixSumsArray = calculate_prefix_sums_array(NumsArray, N),

    TotalSum = array:get(N, PrefixSumsArray),

    NoChangeWays = count_partitions_array(PrefixSumsArray, TotalSum, N),

    ChangedWays = calculate_changed_ways_array(NumsArray, K, N, PrefixSumsArray, TotalSum),

    erlang:max(NoChangeWays, ChangedWays).

calculate_prefix_sums_array(NumsArray, N) ->
    Array = array:new([{size, N + 1}, {fixed, true}]),
    Array0 = array:set(0, 0, Array),
    calculate_prefix_sums_array_loop(0, N - 1, NumsArray, Array0, 0).

calculate_prefix_sums_array_loop(I, MaxI, NumsArray, CurrentArray, CurrentSum) when I =< MaxI ->
    Val = array:get(I, NumsArray),
    NewSum = CurrentSum + Val,
    NewArray = array:set(I + 1, NewSum, CurrentArray),
    calculate_prefix_sums_array_loop(I + 1, MaxI, NumsArray, NewArray, NewSum);
calculate_prefix_sums_array_loop(_I, _MaxI, _NumsArray, CurrentArray, _CurrentSum) ->
    CurrentArray.

count_partitions_array(PrefixSumsArray, TotalSum, N) ->
    case TotalSum rem 2 of
        0 ->
            TargetHalf = TotalSum div 2,
            count_partitions_array_loop(1, N - 1, PrefixSumsArray, TargetHalf, 0);
        _ ->
            0
    end.

count_partitions_array_loop(P, MaxP, PrefixSumsArray, TargetHalf, Acc) when P =< MaxP ->
    Psum = array:get(P, PrefixSumsArray),
    NewAcc = case Psum == TargetHalf of
                 true -> Acc + 1;
                 false -> Acc
             end,
    count_partitions_array_loop(P + 1, MaxP, PrefixSumsArray, TargetHalf, NewAcc);
count_partitions_array_loop(_P, _MaxP, _PrefixSumsArray, _TargetHalf, Acc) ->
    Acc.

calculate_changed_ways_array(NumsArray, K, N, PrefixSumsArray, TotalSum) ->
    RightCounts = init_counts_for_partitions(1, N - 1, PrefixSumsArray, maps:new()),
    LeftCounts = maps:new(),
    MaxWays = 0,

    calculate_changed_ways_loop_array(0, N - 1, NumsArray, K, N, PrefixSumsArray, TotalSum, LeftCounts, RightCounts, MaxWays).

init_counts_for_partitions(P, MaxP, PrefixSumsArray, Acc) when P =< MaxP ->
    Psum = array:get(P, PrefixSumsArray),
    NewAcc = maps:update_with(Psum, fun(V) -> V + 1 end, 1, Acc),
    init_counts_for_partitions(P + 1, MaxP, PrefixSumsArray, NewAcc);
init_counts_for_partitions(_P, _MaxP, _PrefixSumsArray, Acc) ->
    Acc.

calculate_changed_ways_loop_array(I, MaxI, NumsArray, K, N, PrefixSumsArray, TotalSum, LeftCounts, RightCounts, CurrentMaxWays) when I =< MaxI ->
    OldVal = array:get(I, NumsArray),
    Diff = K - OldVal,
    NewTotalSum = TotalSum + Diff,

    WaysForThisChange =
        case NewTotalSum rem 2 of
            0 ->
                TargetHalfSum = NewTotalSum div 2,
                WaysFromLeft = maps:get(TargetHalfSum, LeftCounts, 0),
                WaysFromRight = maps:get(TargetHalfSum - Diff, RightCounts, 0),
                WaysFromLeft + WaysFromRight;
            _ ->
                0
        end,

    NewMaxWays = erlang:max(CurrentMaxWays, WaysForThisChange),

    case I < N - 1 of
        true ->
            ValToMove = array:get(I + 1, PrefixSumsArray),
            UpdatedRightCounts = maps:update_with(ValToMove, fun(V) -> V - 1 end, 0, RightCounts),
            UpdatedLeftCounts = maps:update_with(ValToMove, fun(V) -> V + 1 end, 1, LeftCounts),
            calculate_changed_ways_loop_array(I + 1, MaxI, NumsArray, K, N, PrefixSumsArray, TotalSum, UpdatedLeftCounts, UpdatedRightCounts, NewMaxWays);
        false ->
            calculate_changed_ways_loop_array(I + 1, MaxI, NumsArray, K, N, PrefixSumsArray, TotalSum, LeftCounts, RightCounts, NewMaxWays)
    end;
calculate_changed_ways_loop_array(_I, _MaxI, _NumsArray, _K, _N, _PrefixSumsArray, _TotalSum, _LeftCounts, _RightCounts, CurrentMaxWays) ->
    CurrentMaxWays.