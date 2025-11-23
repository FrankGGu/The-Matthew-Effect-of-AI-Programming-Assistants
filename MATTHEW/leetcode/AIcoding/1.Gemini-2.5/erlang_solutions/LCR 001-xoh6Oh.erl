-module(solution).
-export([divide/2]).

-define(MAX_INT, 2147483647).
-define(MIN_INT, -2147483648).

divide(Dividend, Divisor) ->
    % Handle the specific edge case for overflow: MIN_INT / -1.
    % The conceptual result (2^31) overflows a 32-bit signed integer,
    % so it must be clamped to MAX_INT (2^31 - 1).
    if
        Dividend == ?MIN_INT andalso Divisor == -1 ->
            ?MAX_INT;
        true ->
            % Determine the sign of the result.
            % If one operand is negative and the other is positive, the result is negative.
            IsNegative = (Dividend < 0) xor (Divisor < 0),

            % Work with absolute values to simplify the division logic.
            % Erlang's integers handle arbitrary precision, so abs(?MIN_INT) is fine.
            AbsDividend = abs(Dividend),
            AbsDivisor = abs(Divisor),

            % Perform the division using bit shifts and subtraction on positive numbers.
            Result = divide_positive(AbsDividend, AbsDivisor, 0),

            % Apply the determined sign to the final result.
            if
                IsNegative -> -Result;
                true -> Result
            end
    end.

divide_positive(Dividend, Divisor, Acc) ->
    % If the current dividend is less than the divisor, we can no longer subtract the divisor.
    % The accumulated quotient is the final result.
    if
        Dividend < Divisor ->
            Acc;
        true ->
            % Find the largest multiple of Divisor (Divisor * 2^k) that is less than or equal to Dividend.
            % This is done by repeatedly left-shifting (multiplying by 2) the Divisor and a corresponding multiplier.
            Multiplier = 1,
            ShiftedDivisor = Divisor,
            {FinalMultiplier, FinalShiftedDivisor} = find_largest_multiple(Dividend, Multiplier, ShiftedDivisor),

            % Subtract this largest multiple from the Dividend.
            % Add its corresponding multiplier to the accumulated quotient.
            NewDividend = Dividend - FinalShiftedDivisor,
            NewAcc = Acc + FinalMultiplier,

            % Recurse with the reduced dividend.
            divide_positive(NewDividend, Divisor, NewAcc)
    end.

find_largest_multiple(Dividend, Multiplier, ShiftedDivisor) ->
    % Check if shifting the current ShiftedDivisor one more time (multiplying by 2)
    % would still be less than or equal to the Dividend.
    % Erlang's arbitrary precision integers prevent overflow for ShiftedDivisor bsl 1.
    if
        ShiftedDivisor bsl 1 <= Dividend ->
            find_largest_multiple(Dividend, Multiplier bsl 1, ShiftedDivisor bsl 1);
        true ->
            % If shifting one more time would exceed the Dividend,
            % then the current ShiftedDivisor and Multiplier are the largest valid ones.
            {Multiplier, ShiftedDivisor}
    end.