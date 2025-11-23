-module(solution).
-export([getSum/2]).

getSum(A, B) ->
    % Mask for 32-bit unsigned integer representation (0xFFFFFFFF)
    Mask = (1 bsl 32) - 1, 

    % Initial values for the loop should be masked to ensure they are treated
    % as 32-bit unsigned representations, especially for negative inputs.
    A_initial = A band Mask,
    B_initial = B band Mask,

    % Perform the bitwise sum loop
    ResultUnsigned = getSumLoop(A_initial, B_initial, Mask),

    % Convert the final unsigned 32-bit result to a signed 32-bit integer.
    % If the 31st bit (sign bit in two's complement) is set, it's a negative number.
    if (ResultUnsigned band (1 bsl 31)) /= 0 -> 
        % Convert from unsigned 32-bit to signed 32-bit by subtracting 2^32
        ResultUnsigned - (1 bsl 32);
    true -> 
        % Otherwise, it's a positive number, no conversion needed
        ResultUnsigned
    end.

getSumLoop(A_val, 0, _Mask) ->
    % If B_val (carry) is 0, A_val holds the final sum
    A_val;
getSumLoop(A_val, B_val, Mask) ->
    % Calculate carry: bits that are 1 in both A_val and B_val, shifted left by 1
    Carry = (A_val band B_val) bsl 1,

    % Calculate sum without carry: bits that are 1 in either A_val or B_val, but not both
    Sum = (A_val bxor B_val),

    % Recursively call with the new sum and carry, ensuring both are masked
    % to stay within the 32-bit unsigned representation.
    getSumLoop(Sum band Mask, Carry band Mask, Mask).