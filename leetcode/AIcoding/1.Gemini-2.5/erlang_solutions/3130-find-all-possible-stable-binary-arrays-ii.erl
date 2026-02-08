-module(solution).
-export([number_of_stable_arrays/3]).

number_of_stable_arrays(Zero, One, Limit) ->
    MOD = 1000000007,

    % Create a 3D array for DP table
    % DP[i][j][0] for ending with '0'
    % DP[i][j][1] for ending with '1'
    % Dimensions: (Zero+1) x (One+1) x 2
    % Initialize with zeros
    % array:new(Size, [{default, DefaultValue}])
    DP_Rows = array:new(Zero + 1, [{default, array:new(One + 1, [{default, array:new(2, [{default, 0}])}])}]),

    % Helper function to get value from DP table
    GetDP = fun(I, J, K, Arr) ->
        array:get(K, array:get(J, array:get(I, Arr)))
    end,

    % Helper function to set value in DP table
    SetDP = fun(I, J, K, Val, Arr) ->
        RowArr = array:get(I, Arr),
        ColArr = array:get(J, RowArr),
        NewColArr = array:set(K, Val, ColArr),
        NewRowArr = array:set(J, NewColArr, RowArr),
        array:set(I, NewRowArr, Arr)
    end,

    % Fill DP table
    DP = fill_dp_outer_loop(0, Zero, One, Limit, MOD, DP_Rows, GetDP, SetDP),

    % Final result
    (GetDP(Zero, One, 0, DP) + GetDP(Zero, One, 1, DP)) rem MOD.

fill_dp_outer_loop(I, MaxI, MaxJ, Limit, MOD, DP_Acc, GetDP, SetDP) when I =< MaxI ->
    DP_Current_I = fill_dp_inner_loop(I, 0, MaxJ, Limit, MOD, DP_Acc, GetDP, SetDP),
    fill_dp_outer_loop(I + 1, MaxI, MaxJ, Limit, MOD, DP_Current_I, GetDP, SetDP);
fill_dp_outer_loop(_I, _MaxI, _MaxJ, _Limit, _MOD, DP_Acc, _GetDP, _SetDP) ->
    DP_Acc.

fill_dp_inner_loop(I, J, MaxJ, Limit, MOD, DP_Acc, GetDP, SetDP) when J =< MaxJ ->
    NewDP_Acc =
        if
            I == 0 andalso J == 0 ->
                DP_Acc; % No characters, no stable array
            true ->
                CurrentDP = DP_Acc,

                % Calculate DP[I][J][0] (ending with '0')
                UpdatedDP_Acc1 =
                    if
                        I > 0 ->
                            if J == 0 -> % Case: only zeros
                                if I =< Limit ->
                                    SetDP(I, J, 0, 1, CurrentDP);
                                else ->
                                    SetDP(I, J, 0, 0, CurrentDP) % More than limit zeros, not valid
                                end;
                            true -> % I > 0 and J > 0, ending with '0'
                                SumK = calculate_sum_k(I, J, 0, Limit, MOD, CurrentDP, GetDP),
                                SetDP(I, J, 0, SumK rem MOD, CurrentDP)
                            end;
                        true -> % I == 0
                            CurrentDP
                    end,

                % Calculate DP[I][J][1] (ending with '1')
                UpdatedDP_Acc2 =
                    if
                        J > 0 ->
                            if I == 0 -> % Case: only ones
                                if J =< Limit ->
                                    SetDP(I, J, 1, 1, UpdatedDP_Acc1);
                                else ->
                                    SetDP(I, J, 1, 0, UpdatedDP_Acc1) % More than limit ones, not valid
                                end;
                            true -> % J > 0 and I > 0, ending with '1'
                                SumK = calculate_sum_k(I, J, 1, Limit, MOD, UpdatedDP_Acc1, GetDP),
                                SetDP(I, J, 1, SumK rem MOD, UpdatedDP_Acc1)
                            end;
                        true -> % J == 0
                            UpdatedDP_Acc1
                    end,
                UpdatedDP_Acc2
        end,
    fill_dp_inner_loop(I, J + 1, MaxJ, Limit, MOD, NewDP_Acc, GetDP, SetDP);
fill_dp_inner_loop(_I, _J, _MaxJ, _Limit, _MOD, DP_Acc, _GetDP, _SetDP) ->
    DP_Acc.

calculate_sum_k(I, J, EndChar, Limit, MOD, DP_Acc, GetDP) ->
    calculate_sum_k_loop(1, I, J, EndChar, Limit, MOD, DP_Acc, GetDP, 0).

calculate_sum_k_loop(K, I, J, EndChar, Limit, MOD, DP_Acc, GetDP, AccSum) when K =< Limit ->
    Term =
        if
            EndChar == 0 -> % Calculating dp[I][J][0], sum dp[I-k][J][1]
                if I - K >= 0 -> GetDP(I - K, J, 1, DP_Acc);
                   true -> 0
                end;
            EndChar == 1 -> % Calculating dp[I][J][1], sum dp[I][J-k][0]
                if J - K >= 0 -> GetDP(I, J - K, 0, DP_Acc);
                   true -> 0
                end
        end,
    NewAccSum = (AccSum + Term) rem MOD,
    calculate_sum_k_loop(K + 1, I, J, EndChar, Limit, MOD, DP_Acc, GetDP, NewAccSum);
calculate_sum_k_loop(_K, _I, _J, _EndChar, _Limit, _MOD, _DP_Acc, _GetDP, AccSum) ->
    AccSum.