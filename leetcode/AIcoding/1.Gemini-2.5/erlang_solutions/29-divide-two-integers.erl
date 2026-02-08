-module(solution).
-export([divide/2]).

divide(Dividend, Divisor) ->
    MAX_INT = (1 bsl 31) - 1,
    MIN_INT = -(1 bsl 31),

    % Handle the overflow case: MIN_INT / -1 should be MAX_INT
    if
        Dividend == MIN_INT andalso Divisor == -1 ->
            MAX_INT;
        true ->
            % Determine the sign of the result
            IsNegative = (Dividend < 0) xor (Divisor < 0),

            % Convert both to negative for consistent subtraction logic.
            % This avoids issues with abs(MIN_INT) overflowing MAX_INT.
            N_dividend = if Dividend > 0 then -Dividend else Dividend end,
            N_divisor = if Divisor > 0 then -Divisor else Divisor end,

            divide_recursive(N_dividend, N_divisor, 0, IsNegative, MAX_INT, MIN_INT)
    end.

divide_recursive(N_dividend, N_divisor, Acc_quotient, IsNegative, MAX_INT, MIN_INT) ->
    if
        N_dividend > N_divisor -> % N_dividend is less negative than N_divisor, so we can't subtract anymore
            Result = if IsNegative then -Acc_quotient else Acc_quotient end,
            % Ensure result stays within 32-bit signed integer range
            if
                Result > MAX_INT -> MAX_INT;
                Result < MIN_INT -> MIN_INT;
                true -> Result
            end;
        true ->
            % Find the largest multiple of N_divisor that is still <= N_dividend
            % (i.e., N_divisor * 2^k is less negative than N_dividend)
            {Shifted_divisor, Shift_multiple} = find_max_shift(N_dividend, N_divisor, 1),

            New_dividend = N_dividend - Shifted_divisor,
            New_quotient = Acc_quotient + Shift_multiple,

            divide_recursive(New_dividend, N_divisor, New_quotient, IsNegative, MAX_INT, MIN_INT)
    end.

find_max_shift(N_dividend, Current_divisor, Current_multiple) ->
    % Check if we can shift Current_divisor left by 1 (multiply by 2)
    % and the result is still a valid negative number that can be subtracted.
    Next_divisor = Current_divisor bsl 1,
    if
        % 1. Next_divisor must be less negative than or equal to N_dividend (i.e. N_dividend <= Next_divisor)
        % 2. Next_divisor must be negative (not overflowed to 0 or positive)
        N_dividend <= Next_divisor andalso Next_divisor < 0 ->
            find_max_shift(N_dividend, Next_divisor, Current_multiple bsl 1);
        true ->
            {Current_divisor, Current_multiple}
    end.