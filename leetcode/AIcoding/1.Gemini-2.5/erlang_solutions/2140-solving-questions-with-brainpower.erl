-module(solution).
-export([most_points/1]).

most_points(Questions) ->
    N = length(Questions),

    % Convert the list of questions to a gb_array for O(1) indexed access.
    % Questions are 0-indexed in the array.
    QuestionsArray = gb_array:from_list(Questions),

    % DP array to store maximum points.
    % dp[i] will store the maximum points obtainable starting from question `i`.
    % The array size is N+1. dp[N] will be 0 (no questions left).
    % Initialize all values to 0.
    DP = gb_array:new(N + 1, [{default, 0}]),

    % Iterate backwards from N-1 down to 0 to fill the DP array.
    % This is a tail-recursive helper function.
    calculate_dp(Index, CurrentDP) when Index < 0 ->
        CurrentDP;
    calculate_dp(Index, CurrentDP) ->
        % Get points and brainpower for the current question (Index).
        {Points_i, Brainpower_i} = gb_array:get(Index, QuestionsArray),

        % Option 1: Skip the current question.
        % The points obtained would be the max points from the next question (Index + 1).
        SkipPoints = gb_array:get(Index + 1, CurrentDP),

        % Option 2: Solve the current question.
        % We get Points_i.
        % We cannot solve questions from Index + 1 to Index + Brainpower_i.
        % The next question we can consider is Index + Brainpower_i + 1.
        % If this index is >= N, it means no more questions can be solved, so 0 points from there.
        NextIndexForSolve = Index + Brainpower_i + 1,
        PointsFromNext = gb_array:get(min(N, NextIndexForSolve), CurrentDP),
        SolvePoints = Points_i + PointsFromNext,

        % The maximum points for the current index is the maximum of the two options.
        CurrentMax = max(SkipPoints, SolvePoints),

        % Update the DP array for the current index.
        UpdatedDP = gb_array:set(Index, CurrentMax, CurrentDP),

        % Recurse for the previous index.
        calculate_dp(Index - 1, UpdatedDP).

    % Start the calculation from the last question (N-1).
    FinalDP = calculate_dp(N - 1, DP),

    % The result is the maximum points obtainable starting from the first question (index 0).
    gb_array:get(0, FinalDP).