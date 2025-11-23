-module(solution).
-export([total_traveled/1]).

total_traveled(Distances) ->
    total_traveled(Distances, 0, 0).

total_traveled([], _, Total) ->
    Total;
total_traveled([D | T], Prev, Total) ->
    NewTotal = Total + abs(D - Prev),
    total_traveled(T, D, NewTotal).