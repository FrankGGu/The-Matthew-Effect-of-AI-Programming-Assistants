-module(solution).
-export([maximize_tower_height/1]).

maximize_tower_height(Cubes) ->
    Sorted = lists:sort(fun(A, B) -> A =< B end, Cubes),
    build_towers(Sorted, 0, 0).

build_towers([], _, Total) -> Total;
build_towers([H | T], Prev, Total) when H > Prev ->
    build_towers(T, H, Total + H);
build_towers([H | T], Prev, Total) ->
    build_towers(T, Prev + 1, Total + Prev + 1).