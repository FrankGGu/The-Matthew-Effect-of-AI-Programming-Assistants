-module(solution).
-export([minimum_effort/1]).

minimum_effort(Tasks) ->
    Sorted = lists:sort(fun([A1, M1], [A2, M2]) -> (M1 - A1) >= (M2 - A2) end, Tasks),
    calculate(Sorted, 0).

calculate([], Energy) -> Energy;
calculate([[Actual, Minimum] | Rest], Energy) ->
    Required = max(Minimum, Energy + Actual),
    calculate(Rest, Required).