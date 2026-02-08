-module(solution).
-export([abbreviateProduct/2]).

abbreviateProduct(Left, Right) ->
    % Handle product of 0
    if
        Left =< 0 andalso Right >= 0 ->
            "0";
        true ->
            solve(Left, Right)
    end.

solve(Left, Right) ->
    % 1. Calculate Z (count of trailing zeros)
    Z2 = count_factors_in_factorial(2, Right) - count_factors_in_factorial(2, Left - 1),
    Z5 = count_factors_in_factorial(5, Right) - count_factors_in_factorial(5, Left - 1),
    Z = min(Z2, Z5),

    % 2. Calculate EffectiveLog10 and k_X (number of digits in X)
    TotalLog10 = calculate_total_log10(Left, Right, 0.0),
    EffectiveLog10 = TotalLog10 - Z,
    KX = trunc(EffectiveLog10) + 1,

    % 3. Construct the result string based on k_X
    if
        KX =< 10 ->
            X_val = calculate_X_val(Left, Right, Z, 1, 0, 0),
            if
                Z == 0 ->
                    integer_to_list(X_val);
                true ->
                    io_lib:format("~w~s~w", [X_val, "e", Z])
            end;
        true -> % KX > 10
            % Calculate Prefix (first 5 digits of X)
            PrefixVal = trunc(math:pow(10, EffectiveLog10 - trunc(EffectiveLog10) + 4)),
            PrefixStr = integer_to_list(PrefixVal),

            % Calculate Suffix (last 5 digits of X)
            ModVal = 100000,
            SuffixProduct = calculate_suffix_product(Left, Right, Z, ModVal, 1, 0, 0),
            SuffixStr = io_lib:format("~5.0w", [SuffixProduct]),

            io_lib:format("~s...~s~s~w", [PrefixStr, SuffixStr, "e", Z])
    end.

count_factors_in_factorial(Prime, N) when N < Prime -> 0;
count_factors_in_factorial(Prime, N) ->
    count_factors_in_factorial_loop(Prime, N, Prime, 0).

count_factors_in_factorial_loop(_Prime, N, CurrentPower, Acc) when CurrentPower > N -> Acc;
count_factors_in_factorial_loop(Prime, N, CurrentPower, Acc) ->
    NewAcc = Acc + N div CurrentPower,
    NewCurrentPower = CurrentPower * Prime,
    count_factors_in_factorial_loop(Prime, N, NewCurrentPower, NewAcc).

calculate_total_log10(I, Right, Acc) when I > Right -> Acc;
calculate_total_log10(I, Right, Acc) ->
    calculate_total_log10(I + 1, Right, Acc + math:log10(I)).

remove_factor_from_num(Num, Factor, Z, CurrentRemoved) ->
    remove_factor_from_num_loop(Num, Factor, Z, CurrentRemoved, Num).

remove_factor_from_num_loop(_OriginalNum, _Factor, Z, CurrentRemoved, ModifiedNum) when CurrentRemoved >= Z ->
    {ModifiedNum, CurrentRemoved};
remove_factor_from_num_loop(OriginalNum, Factor, Z, CurrentRemoved, ModifiedNum) ->
    if
        ModifiedNum rem Factor == 0 ->
            remove_factor_from_num_loop(OriginalNum, Factor, Z, CurrentRemoved + 1, ModifiedNum div Factor);
        true ->
            {ModifiedNum, CurrentRemoved}
    end.

calculate_X_val(I, Right, Z, CurrentXVal, CurrentTwosRemoved, CurrentFivesRemoved) when I > Right ->
    CurrentXVal;
calculate_X_val(I, Right, Z, CurrentXVal, CurrentTwosRemoved, CurrentFivesRemoved) ->
    {TempI_2, NewTwosRemoved} = remove_factor_from_num(I, 2, Z, CurrentTwosRemoved),
    {TempI_5, NewFivesRemoved} = remove_factor_from_num(TempI_2, 5, Z, NewTwosRemoved), % Pass NewTwosRemoved here
    NewXVal = CurrentXVal * TempI_5,
    calculate_X_val(I + 1, Right, Z, NewXVal, NewTwosRemoved, NewFivesRemoved).

calculate_suffix_product(I, Right, Z, ModVal, CurrentSuffixProduct, CurrentTwosRemoved, CurrentFivesRemoved) when I > Right ->
    CurrentSuffixProduct;
calculate_suffix_product(I, Right, Z, ModVal, CurrentSuffixProduct, CurrentTwosRemoved, CurrentFivesRemoved) ->
    {TempI_2, NewTwosRemoved} = remove_factor_from_num(I, 2, Z, CurrentTwosRemoved),
    {TempI_5, NewFivesRemoved} = remove_factor_from_num(TempI_2, 5, Z, NewTwosRemoved), % Pass NewTwosRemoved here
    NewSuffixProduct = (CurrentSuffixProduct * TempI_5) rem ModVal,
    calculate_suffix_product(I + 1, Right, Z, ModVal, NewSuffixProduct, NewTwosRemoved, NewFivesRemoved).