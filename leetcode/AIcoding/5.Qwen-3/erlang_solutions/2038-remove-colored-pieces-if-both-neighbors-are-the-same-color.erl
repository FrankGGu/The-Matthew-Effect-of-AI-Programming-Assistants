-module(remove_colored_pieces).
-export([remove_colored_pieces/1]).

remove_colored_pieces(S) ->
    remove_colored_pieces(S, []).

remove_colored_pieces([], Acc) ->
    lists:reverse(Acc);
remove_colored_pieces([C | T], [P | _] = Acc) when P == C ->
    remove_colored_pieces(T, Acc);
remove_colored_pieces([C | T], Acc) ->
    remove_colored_pieces(T, [C | Acc]).