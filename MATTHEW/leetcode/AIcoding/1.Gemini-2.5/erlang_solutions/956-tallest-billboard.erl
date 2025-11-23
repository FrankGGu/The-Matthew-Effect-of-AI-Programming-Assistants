-module(solution).
-export([tallestBillboard/1]).

tallestBillboard(Rods) ->
    % dp is a map where keys are differences (Diff) and values are the maximum
    % sum of the shorter billboard for that difference.
    % Initialize dp with {0 => 0}, meaning two billboards of height 0,
    % difference 0, and shorter sum 0.
    DP0 = #{0 => 0},

    % Iterate through each rod
    FinalDP = lists:foldl(
        fun(Rod, CurrentDP) ->
            % For each rod, we create a NewDP map based on the CurrentDP.
            % We iterate through all states in CurrentDP and for each state,
            % we consider adding the current rod in two ways.
            lists:foldl(
                fun({Diff, ShorterSum}, AccDP) ->
                    % Option 1: Add Rod to the taller billboard
                    % Current heights are S (ShorterSum) and S+D (ShorterSum + Diff).
                    % Add Rod to S+D.
                    % New heights: S and S+D+Rod.
                    % New difference: D+Rod. New shorter sum: S.
                    NewDiff1 = Diff + Rod,
                    NewShorterSum1 = ShorterSum,
                    UpdatedAccDP1 = maps:update_with(NewDiff1, fun(OldSum) -> max(OldSum, NewShorterSum1) end, NewShorterSum1, AccDP),

                    % Option 2: Add Rod to the shorter billboard
                    % Current heights are S and S+D. Add Rod to S.
                    % New heights: S+Rod and S+D.
                    % The new shorter/taller depends on whether S+Rod is greater than S+D.
                    % This simplifies to comparing Rod vs Diff.
                    NewDiff2 = abs(Diff - Rod),
                    NewShorterSum2 = 
                        if
                            Rod >= Diff -> % Original shorter (S) with Rod is now taller or equal to original taller (S+D)
                                ShorterSum + Diff; % The original taller (S+D) is now the shorter one
                            true -> % Original taller (S+D) is still taller than original shorter (S) with Rod
                                ShorterSum + Rod % The original shorter (S) with Rod is still the shorter one
                        end,
                    maps:update_with(NewDiff2, fun(OldSum) -> max(OldSum, NewShorterSum2) end, NewShorterSum2, UpdatedAccDP1)
                end,
                CurrentDP, % Start the accumulator for this rod with the states from the previous rod
                maps:to_list(CurrentDP) % Iterate over current DP states
            )
        end,
        DP0,
        Rods
    ),

    % The final answer is the maximum shorter sum when the difference is 0.
    % If 0 is not a key in FinalDP, it means no solution where both billboards are equal height,
    % in which case the problem implies 0. (e.g. Rods = [1], result is 0).
    maps:get(0, FinalDP, 0).