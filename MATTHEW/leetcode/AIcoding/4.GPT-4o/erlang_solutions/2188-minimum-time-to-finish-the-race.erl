-module(solution).
-export([minTimeToFinishRace/3]).

minTimeToFinishRace(D, R, T) ->
    MinTime = fun(X) -> X + D div (X * R) end,
    lower_bound(1, T, MinTime).

lower_bound(Low, High, Fun) when Low < High ->
    Mid = (Low + High) div 2,
    case Fun(Mid) > T of
        true -> lower_bound(Low, Mid, Fun);
        false -> lower_bound(Mid + 1, High, Fun)
    end;
lower_bound(Low, High, _Fun) -> Low.