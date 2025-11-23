-module(solution).
-export([max_consecutive_floors/2]).

max_consecutive_floors(N, special) ->
    SortedSpecial = lists:sort(special),
    max_consecutive_floors_helper(N, SortedSpecial, 0, 0).

max_consecutive_floors_helper(N, [], Last, Max) ->
    Max2 = max(Max, N - Last),
    Max2;

max_consecutive_floors_helper(N, [H|T], Last, Max) ->
    Max2 = max(Max, H - Last - 1),
    max_consecutive_floors_helper(N, T, H, Max2).