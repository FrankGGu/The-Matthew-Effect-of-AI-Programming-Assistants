-module(solution).
-export([maximumRobots/2]).

maximumRobots(ChargeTimes, Budget) ->
    N = length(ChargeTimes),
    maximum_robots(ChargeTimes, Budget, N, 0, 0, 0).

maximum_robots(ChargeTimes, Budget, N, Start, End, Max) when Start < N ->
    NewEnd = max(End, Start),
    {CurrentSum, CurrentMax} = calculate_sum_and_max(ChargeTimes, Start, NewEnd),
    case CurrentSum =< Budget of
        true ->
            maximum_robots(ChargeTimes, Budget, N, Start, NewEnd + 1, max(Max, NewEnd - Start + 1));
        false ->
            maximum_robots(ChargeTimes, Budget, N, Start + 1, Start + 1, Max)
    end;
maximum_robots(_, _, _, _, _, Max) ->
    Max.

calculate_sum_and_max(ChargeTimes, Start, End) ->
    lists:foldl(fun(X, {Sum, Max}) -> {Sum + X, max(Max, X)} end, {0, 0}, lists:sublist(ChargeTimes, Start + 1, End - Start)).