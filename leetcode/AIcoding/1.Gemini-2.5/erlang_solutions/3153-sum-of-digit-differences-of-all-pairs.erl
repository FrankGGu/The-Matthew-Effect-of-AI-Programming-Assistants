-module(solution).
-export([sumDigitDifferences/1]).

sumDigitDifferences(Nums) ->
    MaxNum = lists:foldl(fun(X, Acc) -> erlang:max(X, Acc) end, 0, Nums),
    MaxDigits = num_digits(MaxNum),
    calculate_total_diff(Nums, 0, MaxDigits, 0).

num_digits(N) when N > 0 ->
    num_digits_acc(N, 0).

num_digits_acc(0, Acc) -> Acc;
num_digits_acc(N, Acc) ->
    num_digits_acc(N div 10, Acc + 1).

calculate_total_diff(_Nums, CurrentDigitPos, MaxDigits, TotalAcc) when CurrentDigitPos >= MaxDigits ->
    TotalAcc;
calculate_total_diff(Nums, CurrentDigitPos, MaxDigits, TotalAcc) ->
    Counts = array:new([{size, 10}, {fixed, true}, {default, 0}]),

    PowerOf10 = erlang:trunc(math:pow(10, CurrentDigitPos)),

    NewCounts = lists:foldl(fun(Num, AccCounts) ->
                                    Digit = (Num div PowerOf10) rem 10,
                                    CurrentCount = array:get(Digit, AccCounts),
                                    array:set(Digit, CurrentCount + 1, AccCounts)
                            end, Counts, Nums),

    PositionDiff = calculate_position_diff(NewCounts),

    calculate_total_diff(Nums, CurrentDigitPos + 1, MaxDigits, TotalAcc + PositionDiff).

calculate_position_diff(CountsArray) ->
    calculate_position_diff_acc(CountsArray, 0, 0).

calculate_position_diff_acc(CountsArray, D1, Acc) when D1 > 9 ->
    Acc;
calculate_position_diff_acc(CountsArray, D1, Acc) ->
    CountD1 = array:get(D1, CountsArray),
    PositionDiffTerm = calculate_position_diff_inner(CountsArray, D1 + 1, CountD1, D1, 0),
    calculate_position_diff_acc(CountsArray, D1 + 1, Acc + PositionDiffTerm).

calculate_position_diff_inner(CountsArray, D2, CountD1, D1, Acc) when D2 > 9 ->
    Acc;
calculate_position_diff_inner(CountsArray, D2, CountD1, D1, Acc) ->
    CountD2 = array:get(D2, CountsArray),
    Diff = D2 - D1,
    Term = CountD1 * CountD2 * Diff,
    calculate_position_diff_inner(CountsArray, D2 + 1, CountD1, D1, Acc + Term).