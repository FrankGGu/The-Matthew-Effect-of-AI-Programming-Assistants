-module(solution).
-export([minimumSwaps/2]).

minimumSwaps(S1, S2) ->
    {XyCount, YxCount} = count_mismatches(S1, S2, 0, 0),

    % If XyCount and YxCount have different parities, their sum will be odd.
    % It's impossible to make strings equal in this case.
    % e.g., one 'xy' mismatch and zero 'yx' mismatches.
    % Total number of 'x's in s1+s2 must be even, and 'y's in s1+s2 must be even.
    % This implies (XyCount + YxCount) must be even.
    if (XyCount + YxCount) rem 2 /= 0 ->
        -1;
    true ->
        % Calculate swaps for paired mismatches
        Swaps = XyCount div 2 + YxCount div 2,

        % If both XyCount and YxCount are odd, there's one 'xy' and one 'yx' mismatch remaining.
        % These require 2 additional swaps.
        if XyCount rem 2 == 1 -> % If XyCount is odd, YxCount must also be odd due to the parity check above.
            Swaps + 2;
        true ->
            Swaps
        end
    end.

count_mismatches([], [], XyAcc, YxAcc) ->
    {XyAcc, YxAcc};
count_mismatches([H1|T1], [H2|T2], XyAcc, YxAcc) ->
    case {H1, H2} of
        {$x, $y} -> count_mismatches(T1, T2, XyAcc + 1, YxAcc);
        {$y, $x} -> count_mismatches(T1, T2, XyAcc, YxAcc + 1);
        _ -> count_mismatches(T1, T2, XyAcc, YxAcc) % Characters are same, or other combinations (not relevant)
    end.