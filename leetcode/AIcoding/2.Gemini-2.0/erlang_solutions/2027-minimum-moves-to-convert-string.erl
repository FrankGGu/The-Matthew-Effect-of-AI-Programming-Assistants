-module(minimum_moves).
-export([minimum_moves/1]).

minimum_moves(S) ->
    minimum_moves(S, 0, 0).

minimum_moves([], Acc, _) ->
    Acc;
minimum_moves([$'X'|Rest], Acc, I) ->
    minimum_moves(lists:sublist(Rest, 3), Acc + 1, I + 3);
minimum_moves([$'O'|Rest], Acc, I) ->
    minimum_moves(Rest, Acc, I + 1);
minimum_moves([$._|Rest], Acc, I) ->
    minimum_moves(Rest, Acc, I + 1).