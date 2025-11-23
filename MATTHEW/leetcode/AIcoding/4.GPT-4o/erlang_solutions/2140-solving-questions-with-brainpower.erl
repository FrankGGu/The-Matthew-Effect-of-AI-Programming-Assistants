-module(solution).
-export([most_points/1]).

most_points(Questions) ->
    N = length(Questions),
    DP = lists:duplicate(N + 1, 0),
    most_points_helper(Questions, N, DP).

most_points_helper(_, 0, DP) ->
    lists:nth(1, DP);
most_points_helper(Questions, N, DP) ->
    {Points, Brainpower} = lists:nth(N, Questions),
    Without = most_points_helper(Questions, N - 1, DP),
    With = Points + most_points_helper(Questions, max(0, N - Brainpower - 1), DP),
    DP1 = lists:replace(N + 1, max(Without, With), DP),
    most_points_helper(Questions, N - 1, DP1).