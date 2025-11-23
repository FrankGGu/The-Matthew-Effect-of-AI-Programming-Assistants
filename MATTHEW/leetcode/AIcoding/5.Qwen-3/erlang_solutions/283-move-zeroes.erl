-module(move_zeroes).
-export([move_zeros/1]).

move_zeros(List) ->
    move_zeros(List, []).

move_zeros([], Acc) ->
    lists:reverse(Acc);
move_zeros([0 | T], Acc) ->
    move_zeros(T, Acc);
move_zeros([H | T], Acc) ->
    move_zeros(T, [H | Acc]).