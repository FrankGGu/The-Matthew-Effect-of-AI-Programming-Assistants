-module(solution).
-export([maximize_value_of_function/2]).

-define(MAX_LOG_K, 30). % ceil(log2(10^9)) = 30, as 2^29 < 10^9 < 2^30

maximize_value_of_function(Receiver, K) ->
    N = length(Receiver),

    NextP_Arr_Initial = array:new(?MAX_LOG_K),
    SumRec_Arr_Initial = array:new(?MAX_LOG_K),

    % --- Base case i = 0 ---
    NextP_0_Base = array:new(N),
    SumRec_0_Base = array:new(N),

    {FinalNextP_0, FinalSumRec_0} = lists:foldl(
        fun(J, {AccNextP_0, AccSumRec_0}) ->
            R_J = lists:nth(J + 1, Receiver), 
            AccNextP_0_Updated = array:set(J, R_J, AccNextP_0),
            AccSumRec_0_Updated = array:set(J, R_J, AccSumRec_0),
            {AccNextP_0_Updated, AccSumRec_0_Updated}
        end,
        {NextP_0_Base, SumRec_0_Base},
        lists:seq(0, N-1)
    ),

    NextP_Arr_Level0 = array:set(0, FinalNextP_0, NextP_Arr_Initial),
    SumRec_Arr_Level0 = array:set(0, FinalSumRec_0, SumRec_Arr_Initial),

    % --- Fill tables for i > 0 (from 1 to MAX_LOG_K - 1) ---
    {FinalNextP_Arr, FinalSumRec_Arr} = lists:foldl(
        fun(I, {AccNextP_Arr, AccSumRec_Arr}) ->
            CurrentNextP_I_Minus_1 = array:get(I - 1, AccNextP_Arr),
            CurrentSumRec_I_Minus_1 = array:get(I - 1, AccSumRec_Arr),

            NextP_I_Current = array:new(N),
            SumRec_I_Current = array:new(N),

            {NewNextP_I, NewSumRec_I} = lists:foldl(
                fun(J, {AccNextP_I_Inner, AccSumRec_I_Inner}) ->
                    IntermediatePlayer = array:get(J, CurrentNextP_I_Minus_1),

                    NextPlayer_I_J = array:get(IntermediatePlayer, CurrentNextP_I_Minus_1),

                    SumReceivers_I_J = array:get(J, CurrentSumRec_I_Minus_1) + array:get(IntermediatePlayer, CurrentSumRec_I_Minus_1),

                    AccNextP_I_Inner_Updated = array:set(J, NextPlayer_I_J, AccNextP_I_Inner),
                    AccSumRec_I_Inner_Updated = array:set(J, SumReceivers_I_J, AccSumRec_I_Inner),
                    {AccNextP_I_Inner_Updated, AccSumRec_I_Inner_Updated}
                end,
                {NextP_I_Current, SumRec_I_Current},
                lists:seq(0, N-1)
            ),

            AccNextP_Arr_Updated = array:set(I, NewNextP_I, AccNextP_Arr),
            AccSumRec_Arr_Updated = array:set(I, NewSumRec_I, AccSumRec_Arr),
            {AccNextP_Arr_Updated, AccSumRec_Arr_Updated}
        end,
        {NextP_Arr_Level0, SumRec_Arr_Level0},
        lists:seq(1, ?MAX_LOG_K - 1)
    ),

    % --- Calculate maximum f(K, X) for all X from 0 to N-1 ---
    MaxVal = lists:foldl(
        fun(X, CurrentMax) ->
            CurrentPlayer = X,
            TotalSumOfReceivers = 0,

            {FinalCurrentPlayer, FinalTotalSumOfReceivers} = lists:foldl(
                fun(I, {AccCurrentPlayer, AccTotalSumOfReceivers}) ->
                    if (K band (1 bsl I)) /= 0 -> 
                        NextP_I_Arr = array:get(I, FinalNextP_Arr),
                        SumRec_I_Arr = array:get(I, FinalSumRec_Arr),

                        NewTotalSumOfReceivers = AccTotalSumOfReceivers + array:get(AccCurrentPlayer, SumRec_I_Arr),
                        NewCurrentPlayer = array:get(AccCurrentPlayer, NextP_I_Arr),
                        {NewCurrentPlayer, NewTotalSumOfReceivers};
                    true ->
                        {AccCurrentPlayer, AccTotalSumOfReceivers}
                    end
                end,
                {CurrentPlayer, TotalSumOfReceivers},
                lists:seq(?MAX_LOG_K - 1, 0, -1)
            ),

            F_K_X = X + FinalTotalSumOfReceivers,
            max(CurrentMax, F_K_X)
        end,
        0,
        lists:seq(0, N-1)
    ),

    MaxVal.