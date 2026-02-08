-module(solution).
-export([dailyTemperatures/1]).

dailyTemperatures(Temperatures) ->
    N = length(Temperatures),
    Res = lists:duplicate(N, 0),
    dailyTemperatures_helper(Temperatures, Res, 0, N).

dailyTemperatures_helper(_, Res, Index, N) when Index >= N ->
    Res;
dailyTemperatures_helper(Temps, Res, Index, N) ->
    CurrentTemp = lists:nth(Index + 1, Temps),
    NextIndex = find_next_higher(Temps, CurrentTemp, Index + 1, N),
    NewRes = if NextIndex =:= -1 -> Res; true -> lists:replace(Index + 1, NextIndex - Index, Res) end,
    dailyTemperatures_helper(Temps, NewRes, Index + 1, N).

find_next_higher(_, _, Index, N) when Index >= N -> -1;
find_next_higher(Temps, CurrentTemp, Index, N) ->
    NextTemp = lists:nth(Index + 1, Temps),
    if NextTemp > CurrentTemp -> Index + 1; true -> find_next_higher(Temps, CurrentTemp, Index + 1, N) end.