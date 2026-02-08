-module(solution).
-export([maximum_energy/2]).

maximum_energy(EnergyList, K) ->
    N = length(EnergyList),
    EnergyArray = array:from_list(EnergyList),

    InitialMaxVal = -1000000000, 

    calculate_all_dp(N - 1, K, N, EnergyArray, maps:new(), InitialMaxVal).

calculate_all_dp(Index, K, N, EnergyArray, Memo, CurrentMax) when Index >= 0 ->
    Energy_i = array:get(Index, EnergyArray),

    Dp_i_plus_K_val = 
        if Index + K < N ->
            maps:get(Index + K, Memo)
        else
            0
        end,

    Dp_i = Energy_i + Dp_i_plus_K_val,

    NewMemo = maps:put(Index, Dp_i, Memo),

    NewMax = max(CurrentMax, Dp_i),

    calculate_all_dp(Index - 1, K, N, EnergyArray, NewMemo, NewMax);

calculate_all_dp(_Index, _K, _N, _EnergyArray, _Memo, CurrentMax) ->
    CurrentMax.