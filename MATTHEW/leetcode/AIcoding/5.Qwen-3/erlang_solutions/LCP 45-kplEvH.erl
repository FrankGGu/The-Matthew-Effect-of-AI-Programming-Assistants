-module(solution).
-export([bike_racer/1]).

bike_racer(Positions) ->
    Sorted = lists:sort(Positions),
    bike_racer(Sorted, 0, []).

bike_racer([], _, Result) ->
    lists:reverse(Result);
bike_racer([H | T], Index, Result) ->
    bike_racer(T, Index + 1, [Index | Result]).