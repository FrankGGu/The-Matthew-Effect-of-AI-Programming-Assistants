-module(solution).
-export([maxPoints/2]).

maxPoints(N, A) ->
    max_points(N, A, 0, 0, []).

max_points(0, _, Points, Arrows, Current) ->
    {Points, Current};
max_points(N, A, Points, Arrows, Current) when A > 0 ->
    max_points(N - 1, A - 1, Points + N, Arrows + 1, [N | Current]);
max_points(N, A, Points, Arrows, Current) ->
    max_points(N - 1, A, Points, Arrows, Current).

solve(N, A) ->
    {Points, Arrows} = maxPoints(N, A),
    {Points, lists:reverse(Arrows)}.