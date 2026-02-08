-module(solution).
-export([count_collisions/1]).

count_collisions(Road) ->
    count_collisions(Road, 0, 0).

count_collisions([], Count, _) -> Count;
count_collisions([H | T], Count, 0) when H =:= $L -> 
    count_collisions(T, Count, 1);
count_collisions([H | T], Count, 0) when H =:= $R -> 
    count_collisions(T, Count, 0);
count_collisions([H | T], Count, 1) when H =:= $S -> 
    count_collisions(T, Count + 1, 1);
count_collisions([H | T], Count, 1) when H =:= $L -> 
    count_collisions(T, Count + 1, 1);
count_collisions([H | T], Count, 1) when H =:= $R -> 
    count_collisions(T, Count + 1, 0);
count_collisions([H | T], Count, _) when H =:= $S -> 
    count_collisions(T, Count + 1, 1);