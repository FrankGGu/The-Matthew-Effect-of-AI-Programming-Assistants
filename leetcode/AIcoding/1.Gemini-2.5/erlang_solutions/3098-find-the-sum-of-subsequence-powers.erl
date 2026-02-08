-module(solution).
-export([sum_of_powers/3]).

-define(MOD, 1000000007).

sum_of_powers(Nums, K, D) ->
    SortedNumsList = lists:sort(Nums),
    N = length(SortedNumsList),
    SortedNums = array:from_list(SortedNumsList), %% Convert to array for O(1) access

    %% Initialize tables for binomial coefficients C(n, k) and their prefix sums
    %% C_table[n][k] stores C(n, k)
    %% P_C_table[n][k] stores sum_{p=0 to k} C(n, p)
    %% P_PC_table[n][k] stores sum_{p=0 to k} p * C(n, p)
    C_table = array:new([{size, N + 1}, {default, array:new()}]),
    P_C_table = array:new([{size, N + 1}, {default, array:new()}]),
    P_PC_table = array:new([{size, N + 1}, {default, array:new()}]),

    C_table_init = init_C_table(N, C_table),
    {P_C_table_final, P_PC_table_final} = init_prefix_sum_tables(N, C_table_init, P_C_table, P_PC_table),

    calculate_total_sum(SortedNums, N, K, D, P_C_table_final, P_PC_table_final).

init_C_table(N, C_table) ->
    lists:foldl(fun(N_val, AccC_table) ->
        RowC = array:new([{size, N_val + 1}, {default, 0}]),
        RowC_with_C_n_0 = array:set(0, 1, RowC), %% C(N_val, 0) = 1

        UpdatedRowC = lists:foldl(fun(K_val, AccRowC) ->
            Val = if K_val == N_val ->
                        1; %% C(N_val, N_val) = 1
                    true ->
                        C_prev_k_minus_1 = array:get(K_val - 1, array:get(N_val - 1, AccC_table)),
                        C_prev_k = array:get(K_val, array:get(N_val - 1, AccC_table)),
                        (C_prev_k_minus_1 + C_prev_k) rem ?MOD
                  end,
            array:set(K_val, Val, AccRowC)
        end, RowC_with_C_n_0, lists:seq(1, N_val)),
        array:set(N_val, UpdatedRowC, AccC_table)
    end, C_table, lists:seq(0, N)).

init_prefix_sum_tables(N, C_table, P_C_table, P_PC_table) ->
    lists:foldl(fun(N_val, {AccP_C, AccP_PC}) ->
        RowP_C = array:new([{size, N_val + 1}, {default, 0}]),
        RowP_PC = array:new([{size, N_val + 1}, {default, 0}]),

        Current_C_Row = array:get(N_val, C_table),

        {FinalRowP_C, FinalRowP_PC} = lists:foldl(fun(K_val, {CurrentRowP_C, CurrentRowP_PC}) ->
            C_nk = array:get(K_val, Current_C_Row),

            PrevP_C = if K_val > 0 -> array:get(K_val - 1, CurrentRowP_C); true -> 0 end,
            P_C_nk = (PrevP_C + C_nk) rem ?MOD,
            UpdatedRowP_C = array:set(K_val, P_C_nk, CurrentRowP_C),

            PrevP_PC = if K_val > 0 -> array:get(K_val - 1, CurrentRowP_PC); true -> 0 end,
            P_PC_nk = (PrevP_PC + (K_val * C_nk) rem ?MOD) rem ?MOD,
            UpdatedRowP_PC = array:set(K_val, P_PC_nk, CurrentRowP_PC),

            {UpdatedRowP_C, UpdatedRowP_PC}
        end, {RowP_C, RowP_PC}, lists:seq(0, N_val)),

        UpdatedP_C_table = array:set(N_val, FinalRowP_C, AccP_C),
        UpdatedP_PC_table = array:set(N_val, FinalRowP_PC, AccP_PC),
        {UpdatedP_C_table, UpdatedP_PC_table}
    end, {P_C_table, P_PC_table}, lists:seq(0, N)).

calculate_total_sum(SortedNums, N, K, D, P_C_table, P_PC_table) ->
    lists:foldl(fun(I, AccSum) ->
        lists:foldl(fun(J, AccSum2) ->
            NumI = array:get(I, SortedNums),
            NumJ = array:get(J, SortedNums),
            Diff = NumJ - NumI,

            if Diff < D ->
                AccSum2;
            true ->
                NumMid = J - I - 1,
                MinP = max(0, K - 2), %% Minimum number of intermediate elements
                MaxP = NumMid,         %% Maximum number of intermediate elements

                if MinP > MaxP ->
                    AccSum2;
                true ->
                    %% Calculate sum_{p=MinP to MaxP} C(NumMid, p)
                    SumC_MaxP = array:get(MaxP, array:get(NumMid, P_C_table)),
                    SumC_MinP_minus_1 = if MinP > 0 -> array:get(MinP - 1, array:get(NumMid, P_C_table)); true -> 0 end,
                    SumC_Val = (SumC_MaxP - SumC_MinP_minus_1 + ?MOD) rem ?MOD,

                    %% Calculate sum_{p=MinP to MaxP} p * C(NumMid, p)
                    SumPC_MaxP = array:get(MaxP, array:get(NumMid, P_PC_table)),
                    SumPC_MinP_minus_1 = if MinP > 0 -> array:get(MinP - 1, array:get(NumMid, P_PC_table)); true -> 0 end,
                    SumPC_Val = (SumPC_MaxP - SumPC_MinP_minus_1 + ?MOD) rem ?MOD,

                    %% The sum of (p+2) * C(NumMid, p) is SumPC_Val + 2 * SumC_Val
                    CurrentSubSum = (SumPC_Val + 2 * SumC_Val) rem ?MOD,
                    Term = (Diff * CurrentSubSum) rem ?MOD,
                    (AccSum2 + Term) rem ?MOD
                end
            end
        end, AccSum, lists:seq(I, N - 1))
    end, 0, lists:seq(0, N - 1)).

max(A, B) when A >= B -> A;
max(A, B) -> B.