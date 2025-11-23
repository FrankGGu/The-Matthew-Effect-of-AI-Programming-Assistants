-module(solution).
-export([min_cost_to_make_two_strings_equal/3]).

min_cost_to_make_two_strings_equal(S1, S2, X) ->
    {N01, N10} = count_mismatches(S1, S2, 0, 0),

    if
        X >= 2 ->
            % If the cost of a swap (X) is 2 or more, it's always
            % cheaper or equal to fix each mismatch with a single flip (cost 1).
            % So, the total cost is simply the total number of mismatches.
            N01 + N10;
        true -> % X < 2
            % If the cost of a swap (X) is less than 2, it's beneficial
            % to use swaps to fix pairs of opposite mismatches.
            % A swap can fix one '0'->'1' mismatch and one '1'->'0' mismatch.
            % We can perform min(N01, N10) such swaps. Each costs X.
            % The remaining abs(N01 - N10) mismatches must be fixed by individual flips.
            % Each flip costs 1.
            min(N01, N10) * X + abs(N01 - N10)
    end.

count_mismatches(S1, S2, AccN01, AccN10) ->
    case {S1, S2} of
        {[], []} ->
            % Base case: both strings are empty, return accumulated counts
            {AccN01, AccN10};
        {[H1|T1], [H2|T2]} ->
            % Recursive step: compare current characters
            if
                H1 == H2 ->
                    % Characters match, move to next pair
                    count_mismatches(T1, T2, AccN01, AccN10);
                H1 == $0 ->
                    % S1[i] is '0', S2[i] must be '1' (since H1 /= H2)
                    % Increment N01 count
                    count_mismatches(T1, T2, AccN01 + 1, AccN10);
                true -> % H1 == $1
                    % S1[i] is '1', S2[i] must be '0' (since H1 /= H2)
                    % Increment N10 count
                    count_mismatches(T1, T2, AccN01, AccN10 + 1)
            end
    end.