-module(solution).
-export([checkPerfectNumber/1]).

checkPerfectNumber(Num) ->
    if
        Num =< 1 -> false;
        true ->
            SumDivisors = sum_divisors(2, Num, 1),
            SumDivisors == Num
    end.

sum_divisors(I, Num, CurrentSum) when I * I > Num ->
    CurrentSum;
sum_divisors(I, Num, CurrentSum) ->
    if
        Num rem I == 0 ->
            NewSum = CurrentSum + I,
            if
                I * I == Num ->
                    sum_divisors(I + 1, Num, NewSum);
                true ->
                    sum_divisors(I + 1, Num, NewSum + (Num div I))
            end;
        true ->
            sum_divisors(I + 1, Num, CurrentSum)
    end.