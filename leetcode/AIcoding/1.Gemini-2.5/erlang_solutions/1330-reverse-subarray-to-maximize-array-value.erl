-spec max_array_value(Nums :: [integer()]) -> integer().
max_array_value(Nums) ->
    N = length(Nums),

    BaseValue = calculate_base_value_optimized(Nums),

    MaxGain = calculate_max_gain(Nums, N),

    BaseValue + MaxGain.

calculate_base_value_optimized(Nums) ->
    calculate_base_value_optimized(Nums, 0).

calculate_base_value_optimized([_], Acc) -> Acc;
calculate_base_value_optimized([H1, H2 | T], Acc) ->
    calculate_base_value_optimized([H2 | T], Acc + abs(H1 - H2));
calculate_base_value_optimized([], Acc) -> Acc.

calculate_max_gain(Nums, N) ->
    if N < 2 -> 0;
       true ->
            N0 = hd(Nums),
            NN_1 = lists:last(Nums),

            MaxGain1 = calculate_max_gain_case1_optimized(Nums, N0, 0),
            MaxGain2 = calculate_max_gain_case2_optimized(Nums, NN_1, 0),
            MaxGain3 = calculate_max_gain_case3_optimized(Nums, 0),

            erlang:max(MaxGain1, erlang:max(MaxGain2, MaxGain3))
    end.

calculate_max_gain_case1_optimized(Nums, N0, CurrentMaxGain) ->
    calculate_max_gain_case1_optimized_loop(Nums, N0, CurrentMaxGain).

calculate_max_gain_case1_optimized_loop([_], _N0, AccMaxGain) -> AccMaxGain;
calculate_max_gain_case1_optimized_loop([H1, H2 | T], N0, AccMaxGain) ->
    Gain = abs(N0 - H2) - abs(H1 - H2),
    NewAccMaxGain = erlang:max(AccMaxGain, Gain),
    calculate_max_gain_case1_optimized_loop([H2 | T], N0, NewAccMaxGain).

calculate_max_gain_case2_optimized(Nums, NN_1, CurrentMaxGain) ->
    calculate_max_gain_case2_optimized_loop(Nums, NN_1, CurrentMaxGain).

calculate_max_gain_case2_optimized_loop([_], _NN_1, AccMaxGain) -> AccMaxGain;
calculate_max_gain_case2_optimized_loop([H1, H2 | T], NN_1, AccMaxGain) ->
    Gain = abs(H1 - NN_1) - abs(H1 - H2),
    NewAccMaxGain = erlang:max(AccMaxGain, Gain),
    calculate_max_gain_case2_optimized_loop([H2 | T], NN_1, NewAccMaxGain).

calculate_max_gain_case3_optimized(Nums, CurrentMaxGain) ->
    % Max possible value for nums[i] is 10^9.
    % Max sum is 2*10^9. Min sum is 2.
    % Max diff is 10^9 - 1. Min diff is -(10^9 - 1).
    % Using values outside this range for initial min/max.
    Infinity = 2000000000 + 7, 
    NegInfinity = - (2000000000 + 7),

    MinXPlusY = Infinity,
    MaxXPlusY = NegInfinity,
    MinXMinusY = Infinity,
    MaxXMinusY = NegInfinity,

    {FinalMaxGain, _, _, _, _} = calculate_max_gain_case3_optimized_loop(
        Nums, {CurrentMaxGain, MinXPlusY, MaxXPlusY, MinXMinusY, MaxXMinusY}),
    FinalMaxGain.

calculate_max_gain_case3_optimized_loop([_], Acc) -> Acc;
calculate_max_gain_case3_optimized_loop([H1, H2 | T], {AccMaxGain, AccMinXPlusY, AccMaxXPlusY, AccMinXMinusY, AccMaxXMinusY}) ->
    X = H1,
    Y = H2,

    NewAccMaxGain = erlang:max(AccMaxGain, (X + Y) - AccMinXPlusY),
    NewAccMaxGain1 = erlang:max(NewAccMaxGain, AccMaxXPlusY - (X + Y)),
    NewAccMaxGain2 = erlang:max(NewAccMaxGain1, (X - Y) - AccMinXMinusY),
    NewAccMaxGain3 = erlang:max(NewAccMaxGain2, AccMaxXMinusY - (X - Y)),

    NewMinXPlusY = erlang:min(AccMinXPlusY, X + Y),
    NewMaxXPlusY = erlang:max(AccMaxXPlusY, X + Y),
    NewMinXMinusY = erlang:min(AccMinXMinusY, X - Y),
    NewMaxXMinusY = erlang:max(AccMaxXMinusY, X - Y),

    calculate_max_gain_case3_optimized_loop([H2 | T], {NewAccMaxGain3, NewMinXPlusY, NewMaxXPlusY, NewMinXMinusY, NewMaxXMinusY}).