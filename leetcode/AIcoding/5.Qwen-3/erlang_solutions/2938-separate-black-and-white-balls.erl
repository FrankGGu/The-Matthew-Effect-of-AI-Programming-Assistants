-module(separate_black_and_white_balls).
-export([num_moves/1]).

num_moves(Balls) ->
    num_moves(Balls, 0, 0).

num_moves([], _, Acc) ->
    Acc;
num_moves([$W | T], Count, Acc) ->
    num_moves(T, Count + 1, Acc);
num_moves([$B | T], Count, Acc) ->
    num_moves(T, Count, Acc + Count).