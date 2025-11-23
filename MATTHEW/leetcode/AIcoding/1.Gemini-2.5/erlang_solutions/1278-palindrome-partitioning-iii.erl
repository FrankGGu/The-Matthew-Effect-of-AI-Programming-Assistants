-module(solution).
-export([palindromePartition/2]).

-define(INFINITY, 1000000).

palindromePartition(S, K) ->
    S_list = string:to_chars(S),
    N = length(S_list),

    CostTable = make_cost_table(S_list, N),

    % dp[i][j] = minimum changes for s[0...i-1] into j partitions
    % i from 0 to N, j from 0 to K
    % Initialize dp_table with infinity, dp[0][0] = 0

    DpTableInit = array:new([{fixed, true}, {size, N + 1}]),
    DpTable0 = lists:foldl(fun(Idx, Acc) ->
                                Row = array:new([{fixed, true}, {size, K + 1}, {default, ?INFINITY}]),
                                array:set(Idx, Row, Acc)
                            end, DpTableInit, lists:seq(0, N)),

    % Set dp[0][0] = 0
    Row0 = array:get(0, DpTable0),
    Row0_updated = array:set(0, 0, Row0),
    DpTable = array:set(0, Row0_updated, DpTable0),

    % Fill dp_table
    FinalDpTable = fill_dp_table(1, K, 1, N, DpTable, CostTable),

    array:get(K, array:get(N, FinalDpTable)).

make_cost_table(S_list, N) ->
    CostTableInit = array:new([{fixed, true}, {size, N}]),
    CostTable0 = lists:foldl(fun(Idx, Acc) ->
                                 Row = array:new([{fixed, true}, {size, N}, {default, 0}]),
                                 array:set(Idx, Row, Acc)
                             end, CostTableInit, lists:seq(0, N-1)),

    fill_cost_table_len(2, N, S_list, CostTable0).

fill_cost_table_len(Len, N, S_list, CurrentCostTable) when Len > N -> CurrentCostTable;
fill_cost_table_len(Len, N, S_list, CurrentCostTable) ->
    UpdatedCostTable = fill_cost_table_i(0, N - Len, Len, S_list, CurrentCostTable),
    fill_cost_table_len(Len + 1, N, S_list, UpdatedCostTable).

fill_cost_table_i(I, MaxI, Len, S_list, CurrentCostTable) when I > MaxI -> CurrentCostTable;
fill_cost_table_i(I, MaxI, Len, S_list, CurrentCostTable) ->
    J = I + Len - 1,
    Char_I = lists:nth(I + 1, S_list),
    Char_J = lists:nth(J + 1, S_list),

    Val_I_J =
        if
            Char_I == Char_J ->
                if
                    Len == 2 -> 0;
                    true -> array:get(J - 1, array:get(I + 1, CurrentCostTable))
                end;
            true -> % Char_I /= Char_J
                if
                    Len == 2 -> 1;
                    true -> array:get(J - 1, array:get(I + 1, CurrentCostTable)) + 1
                end
        end,

    Row_I = array:get(I, CurrentCostTable),
    Row_I_updated = array:set(J, Val_I_J, Row_I),
    NextCostTable = array:set(I, Row_I_updated, CurrentCostTable),

    fill_cost_table_i(I + 1, MaxI, Len, S_list, NextCostTable).

fill_dp_table(J, K, I, N, CurrentDpTable, CostTable) when J > K -> CurrentDpTable;
fill_dp_table(J, K, I, N, CurrentDpTable, CostTable) when I > N ->
    fill_dp_table(J + 1, K, 1, N, CurrentDpTable, CostTable);
fill_dp_table(J, K, I, N, CurrentDpTable, CostTable) ->
    CurrentMin = ?INFINITY,
    % P is the split point. s[0...P-1] has J-1 partitions, s[P...I-1] is the J-th partition.
    % P must be at least J-1 (to allow J-1 partitions for s[0...P-1]).
    % P must be at most I-1 (to allow s[P...I-1] to be non-empty).
    PossiblePs = lists:seq(J - 1, I - 1),

    MinVal = lists:foldl(fun(P, AccMin) ->
                             PrevDpVal = array:get(J - 1, array:get(P, CurrentDpTable)),
                             if PrevDpVal =/= ?INFINITY ->
                                 CostVal = array:get(I - 1, array:get(P, CostTable)), % cost[p][i-1]
                                 min(AccMin, PrevDpVal + CostVal)
                             else ->
                                 AccMin
                             end
                         end, CurrentMin, PossiblePs),

    NextDpTable =
        if MinVal =/= ?INFINITY ->
            Row_I = array:get(I, CurrentDpTable),
            Row_I_updated = array:set(J, MinVal, Row_I),
            array:set(I, Row_I_updated, CurrentDpTable)
        else ->
            CurrentDpTable % No change if MinVal is still infinity
        end,

    fill_dp_table(J, K, I + 1, N, NextDpTable, CostTable).