-module(solution).
-export([is_possible_partition/1]).

is_possible_partition(Grid) ->
    M = length(Grid),
    N = length(hd(Grid)),

    if
        M < 2; N < 2 -> false;
        true ->
            TotalSum = lists:sum(lists:map(fun lists:sum/1, Grid)),

            if
                TotalSum rem 4 =/= 0 -> false;
                true ->
                    TargetSum = TotalSum div 4,
                    PrefixSum = build_prefix_sum(Grid, M, N),

                    check_partitions(1, M - 1, 1, N - 1, M, N, PrefixSum, TargetSum)
            end
    end.

check_partitions(R, MaxR, C, MaxC, M, N, PrefixSum, TargetSum) ->
    if
        R > MaxR -> false;
        true ->
            case check_vertical_cuts(R, 1, MaxC, M, N, PrefixSum, TargetSum) of
                true -> true;
                false -> check_partitions(R + 1, MaxR, C, MaxC, M, N, PrefixSum, TargetSum)
            end
    end.

check_vertical_cuts(R, C, MaxC, M, N, PrefixSum, TargetSum) ->
    if
        C > MaxC -> false;
        true ->
            Sum1 = get_sum(PrefixSum, 0, 0, R - 1, C - 1),
            Sum2 = get_sum(PrefixSum, 0, C, R - 1, N - 1),
            Sum3 = get_sum(PrefixSum, R, 0, M - 1, C - 1),
            Sum4 = get_sum(PrefixSum, R, C, M - 1, N - 1),

            if
                Sum1 == TargetSum andalso
                Sum2 == TargetSum andalso
                Sum3 == TargetSum andalso
                Sum4 == TargetSum -> true;
                true -> check_vertical_cuts(R, C + 1, MaxC, M, N, PrefixSum, TargetSum)
            end
    end.

build_prefix_sum(Grid, M, N) ->
    EmptyRow = lists:duplicate(N + 1, 0),
    InitialPrefixSumAcc = [EmptyRow],

    build_prefix_sum_rows(Grid, InitialPrefixSumAcc, 0, M - 1, N - 1).

build_prefix_sum_rows(Grid, CurrentPrefixSumAcc, R, MaxR, MaxC) ->
    if
        R > MaxR -> lists:reverse(CurrentPrefixSumAcc);
        true ->
            PrevP_Row = hd(CurrentPrefixSumAcc),
            GridRow = lists:nth(R + 1, Grid),

            NewP_Row = build_prefix_sum_col_optimized(GridRow, PrevP_Row, 0, MaxC, [0]),

            build_prefix_sum_rows(Grid, [NewP_Row | CurrentPrefixSumAcc], R + 1, MaxR, MaxC)
    end.

build_prefix_sum_col_optimized(GridRow, PrevP_Row, C, MaxC, Acc) ->
    if
        C > MaxC -> lists:reverse(Acc);
        true ->
            GridVal = lists:nth(C + 1, GridRow),

            PrevRow_CurrentCol_Val = lists:nth(C + 1, PrevP_Row),
            CurrentRow_PrevCol_Val = hd(Acc),
            PrevRow_PrevCol_Val = lists:nth(C, PrevP_Row),

            NewPVal = GridVal + PrevRow_CurrentCol_Val + CurrentRow_PrevCol_Val - PrevRow_PrevCol_Val,

            build_prefix_sum_col_optimized(GridRow, PrevP_Row, C + 1, MaxC, [NewPVal | Acc])
    end.

get_sum(PrefixSum, R1, C1, R2, C2) ->
    Val_R2C2 = lists:nth(C2 + 2, lists:nth(R2 + 2, PrefixSum)),
    Val_R1_C2 = lists:nth(C2 + 2, lists:nth(R1 + 1, PrefixSum)),
    Val_R2_C1 = lists:nth(C1 + 1, lists:nth(R2 + 2, PrefixSum)),
    Val_R1_C1 = lists:nth(C1 + 1, lists:nth(R1 + 1, PrefixSum)),

    Val_R2C2 - Val_R1_C2 - Val_R2_C1 + Val_R1_C1.