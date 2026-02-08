-module(solution).
-export([count_sub_multisets/3]).

count_sub_multisets(Nums, L, R) ->
    MOD = 1_000_000_000 + 7,

    % 1. Count frequencies of all numbers and separate zeros
    {FreqMap, ZerosCount} = lists:foldl(
        fun(Num, {AccMap, AccZeros}) ->
            if Num == 0 ->
                {AccMap, AccZeros + 1};
            true ->
                maps:update_with(Num, fun(Count) -> Count + 1 end, 1, AccMap, AccZeros)
            end
        end,
        {#{}, 0},
        Nums
    ),

    % 2. Initialize DP array
    % Dp[s] will store the number of ways to achieve sum s using non-zero elements
    Dp = array:new([{size, R + 1}, {fixed, true}, {default, 0}]),
    Dp1 = array:set(0, 1, Dp), % One way to make sum 0 (empty set)

    % 3. Process non-zero numbers using bounded knapsack (powers-of-2 decomposition)
    DpFinalNonZero = maps:foldl(
        fun(Val, Freq, CurrentDp) ->
            process_val_freq(Val, Freq, 1, CurrentDp, R, MOD)
        end,
        Dp1,
        FreqMap
    ),

    % 4. Adjust for zeros
    ZerosMultiplier = power(2, ZerosCount, MOD),

    TotalCount = lists:foldl(
        fun(S, Acc) ->
            Ways = array:get(S, DpFinalNonZero),
            AdjustedWays = (Ways * ZerosMultiplier) rem MOD,
            (Acc + AdjustedWays) rem MOD
        end,
        0,
        lists:seq(L, R)
    ),
    TotalCount.

process_val_freq(Val, Freq, K, CurrentDp, R, MOD) ->
    if Freq == 0 ->
        CurrentDp;
    true ->
        Take = min(K, Freq),
        ItemVal = Val * Take,

        NewDp = update_dp_down(R, ItemVal, CurrentDp, MOD),

        process_val_freq(Val, Freq - Take, K * 2, NewDp, R, MOD)
    end.

update_dp_down(S, ItemVal, Dp, MOD) when S >= ItemVal ->
    PrevWays = array:get(S - ItemVal, Dp),
    CurrentWays = array:get(S, Dp),
    UpdatedDp = array:set(S, (CurrentWays + PrevWays) rem MOD, Dp),
    update_dp_down(S - 1, ItemVal, UpdatedDp, MOD);
update_dp_down(_, _, Dp, _) ->
    Dp.

power(Base, Exp, Mod) ->
    power_acc(Base, Exp, Mod, 1).

power_acc(_, 0, _, Acc) ->
    Acc;
power_acc(Base, Exp, Mod, Acc) ->
    if Exp rem 2 == 1 ->
        power_acc((Base * Base) rem Mod, Exp div 2, Mod, (Acc * Base) rem Mod);
    true ->
        power_acc((Base * Base) rem Mod, Exp div 2, Mod, Acc)
    end.