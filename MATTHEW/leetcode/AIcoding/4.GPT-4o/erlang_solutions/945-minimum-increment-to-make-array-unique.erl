-module(solution).
-export([min_increment/1]).

min_increment(A) ->
    Sorted = lists:sort(A),
    min_increment(Sorted, 0, 0).

min_increment([], _, Total) -> Total;
min_increment([H | T], Prev, Total) ->
    NewPrev = max(H, Prev + 1),
    min_increment(T, NewPrev, Total + (NewPrev - H)).