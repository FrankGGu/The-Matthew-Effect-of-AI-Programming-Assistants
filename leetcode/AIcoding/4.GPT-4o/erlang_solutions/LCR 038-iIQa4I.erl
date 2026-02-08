-module(solution).
-export([dailyTemperatures/1]).

dailyTemperatures(T) ->
    N = length(T),
    Res = lists:duplicate(N, 0),
    dailyTemperatures(T, Res, N, 0).

dailyTemperatures(_, Res, 0, _) ->
    Res;
dailyTemperatures(T, Res, N, LastIndex) ->
    CurrentTemp = lists:nth(N, T),
    NextIndex = N - 1,
    case find_higher(T, CurrentTemp, NextIndex) of
        -1 -> dailyTemperatures(T, lists:sublist(Res, 1, N - 1) ++ [0], NextIndex, LastIndex);
        Days -> dailyTemperatures(T, lists:sublist(Res, 1, N - 1) ++ [Days], NextIndex, LastIndex)
    end.

find_higher(_, _, 0) -> -1;
find_higher(T, CurrentTemp, Index) ->
    Temp = lists:nth(Index, T),
    if
        Temp > CurrentTemp -> Index - 1; 
        true -> find_higher(T, CurrentTemp, Index - 1)
    end.