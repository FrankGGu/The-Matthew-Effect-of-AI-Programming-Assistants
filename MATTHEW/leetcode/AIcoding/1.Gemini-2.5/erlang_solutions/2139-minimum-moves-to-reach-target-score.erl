-module(solution).
-export([min_moves/2]).

min_moves(Target, MaxDoubles) ->
    min_moves_recursive(Target, MaxDoubles, 0).

min_moves_recursive(1, _MaxDoubles, Moves) ->
    Moves;
min_moves_recursive(Target, 0, Moves) ->
    Moves + (Target - 1);
min_moves_recursive(Target, MaxDoubles, Moves) when Target rem 2 == 1 ->
    min_moves_recursive(Target - 1, MaxDoubles, Moves + 1);
min_moves_recursive(Target, MaxDoubles, Moves) when Target rem 2 == 0 ->
    min_moves_recursive(Target div 2, MaxDoubles - 1, Moves + 1).