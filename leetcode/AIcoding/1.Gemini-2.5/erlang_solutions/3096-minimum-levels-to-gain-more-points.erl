-module(solution).
-export([minimumLevels/1]).

minimumLevels(PossiblePoints) ->
    Scores = lists:map(fun(0) -> 1; (1) -> -1 end, PossiblePoints),
    TotalSum = lists:sum(Scores),
    N = length(Scores),

    % We need to consider k levels, where k ranges from 1 to N-1.
    % This means we will iterate through the first N-1 elements of the Scores list.
    PrefixScores = lists:sublist(Scores, N - 1),

    find_min_k(PrefixScores, TotalSum, 0, 1).

find_min_k([], _TotalSum, _CurrentPrefixSum, _K) ->
    % If we've processed all N-1 possible prefixes and haven't found a solution,
    % return -1.
    -1; 
find_min_k([H|T], TotalSum, CurrentPrefixSum, K) ->
    NewCurrentPrefixSum = CurrentPrefixSum + H,
    if 
        % Check the condition: 2 * (points from first K levels) > (total points)
        2 * NewCurrentPrefixSum > TotalSum ->
            K; % Found the minimum K
        true ->
            % Continue to the next level
            find_min_k(T, TotalSum, NewCurrentPrefixSum, K + 1)
    end.