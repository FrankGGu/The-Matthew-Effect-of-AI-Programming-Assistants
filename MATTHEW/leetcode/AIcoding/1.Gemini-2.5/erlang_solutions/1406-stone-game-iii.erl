-module(solution).
-export([stoneGameIII/1]).

stoneGameIII(StoneValueList) ->
    N = length(StoneValueList),

    % Convert the input list to an array for O(1) indexed access.
    % array:from_list creates a 0-indexed array.
    StoneValue = array:from_list(StoneValueList),

    % dp[i] will store the maximum score difference (current player's score - opponent's score)
    % that can be achieved starting from index i.
    % We need N+3 elements to safely access dp[i+1], dp[i+2], dp[i+3] without
    % going out of bounds. Indices N, N+1, N+2 will represent base cases (no stones left),
    % initialized to 0.
    DP = array:new([{size, N + 3}, {fixed, true}, {default, 0}]),

    % Iterate backwards from N-1 down to 0 to fill the DP array.
    ResultDP = lists:foldr(
        fun(I, CurrentDP) ->
            % Option 1: Take 1 stone (StoneValue[I])
            % The score difference for this turn is StoneValue[I].
            % The next state is dp[I+1], which represents the maximum difference
            % the opponent can achieve from the remaining stones.
            % So, the total difference from current player's perspective is:
            % current_player_score + StoneValue[I] - (opponent_score + opponent_max_diff_from_I+1)
            % = StoneValue[I] - opponent_max_diff_from_I+1
            Val1 = array:get(I, StoneValue) - array:get(I + 1, CurrentDP),

            % Option 2: Take 2 stones (StoneValue[I] + StoneValue[I+1])
            Val2 = if
                       I + 1 < N -> % Check if I+1 is a valid index in StoneValue
                           Sum2 = array:get(I, StoneValue) + array:get(I + 1, StoneValue),
                           Sum2 - array:get(I + 2, CurrentDP);
                       true ->
                           % If not enough stones, this option is invalid.
                           % Use a very small number to ensure it's not chosen.
                           -2_000_000_000
                   end,

            % Option 3: Take 3 stones (StoneValue[I] + StoneValue[I+1] + StoneValue[I+2])
            Val3 = if
                       I + 2 < N -> % Check if I+2 is a valid index in StoneValue
                           Sum3 = array:get(I, StoneValue) + array:get(I + 1, StoneValue) + array:get(I + 2, StoneValue),
                           Sum3 - array:get(I + 3, CurrentDP);
                       true ->
                           % If not enough stones, this option is invalid.
                           % Use a very small number to ensure it's not chosen.
                           -2_000_000_000
                   end,

            % The current player chooses the option that maximizes the score difference.
            MaxVal = lists:max([Val1, Val2, Val3]),
            array:set(I, MaxVal, CurrentDP)
        end,
        DP,
        lists:seq(0, N - 1) % Iterate from N-1 down to 0
    ),

    % The final score difference for Alice (who starts at index 0)
    FinalScoreDiff = array:get(0, ResultDP),

    % Determine the winner based on the final score difference
    if
        FinalScoreDiff > 0 -> "Alice";
        FinalScoreDiff < 0 -> "Bob";
        true -> "Tie"
    end.