-module(solution).
-export([minimizeTheMaximumOfTwoArrays/4]).

gcd(A, 0) -> A;
gcd(A, B) -> gcd(B, A rem B).

lcm(A, B) -> (A div gcd(A, B)) * B.

check(X, Divisor1, Divisor2, Arr1Cnt, Arr2Cnt) ->
    % Count of numbers <= X that are NOT divisible by Divisor1
    N_not_D1 = X - (X div Divisor1),

    % Count of numbers <= X that are NOT divisible by Divisor2
    N_not_D2 = X - (X div Divisor2),

    % Calculate LCM of Divisor1 and Divisor2
    L = lcm(Divisor1, Divisor2),

    % Count of numbers <= X that are NOT divisible by LCM(Divisor1, Divisor2).
    % These are numbers that are suitable for at least one of the arrays.
    N_not_D1_or_not_D2 = X - (X div L),

    % Conditions for X to be a valid maximum:
    % 1. Enough numbers available for Arr1Cnt (not divisible by Divisor1).
    % 2. Enough numbers available for Arr2Cnt (not divisible by Divisor2).
    % 3. Enough unique numbers available in total for both arrays
    %    (numbers not divisible by both Divisor1 and Divisor2, which means
    %    not divisible by LCM(Divisor1, Divisor2)).
    N_not_D1 >= Arr1Cnt andalso
    N_not_D2 >= Arr2Cnt andalso
    N_not_D1_or_not_D2 >= Arr1Cnt + Arr2Cnt.

minimizeTheMaximumOfTwoArrays(Divisor1, Divisor2, Arr1Cnt, Arr2Cnt) ->
    % Binary search range for the maximum value X.
    % Low: Minimum possible value is 1.
    % High: A sufficiently large upper bound.
    % The maximum possible value for Arr1Cnt + Arr2Cnt is 2 * 10^9.
    % In the worst case, if divisors are large, X might need to be slightly
    % larger than Arr1Cnt + Arr2Cnt to get enough numbers.
    % A safe upper bound is 2 * (Arr1Cnt + Arr2Cnt) + 1.
    Low = 1,
    High = 2 * (Arr1Cnt + Arr2Cnt) + 1, 

    binary_search(Low, High, Divisor1, Divisor2, Arr1Cnt, Arr2Cnt, High).

binary_search(Low, High, D1, D2, C1, C2, Ans) when Low =< High ->
    Mid = Low + (High - Low) div 2, % Calculate midpoint to avoid overflow with (Low + High)
    case check(Mid, D1, D2, C1, C2) of
        true ->
            % If Mid is a possible answer, try smaller values
            binary_search(Low, Mid - 1, D1, D2, C1, C2, Mid);
        false ->
            % If Mid is not a possible answer, try larger values
            binary_search(Mid + 1, High, D1, D2, C1, C2, Ans)
    end;
binary_search(_, _, _, _, _, _, Ans) ->
    % Base case: Low > High, return the smallest valid answer found
    Ans.