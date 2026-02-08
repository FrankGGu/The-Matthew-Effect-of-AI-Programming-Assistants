-module(remove_colored_pieces).
-export([can_win/1]).

can_win(Colors) ->
  Alice_moves = count_moves(Colors, $A),
  Bob_moves = count_moves(Colors, $B),
  Alice_moves > Bob_moves.

count_moves(Colors, Piece) ->
  count_moves(Colors, Piece, 0).

count_moves([], _, Count) ->
  Count;
count_moves([_, H, T | Rest], Piece, Count) when H == Piece, H == T ->
  count_moves([H, T | Rest], Piece, Count + 1);
count_moves([_ | Rest], Piece, Count) ->
  count_moves(Rest, Piece, Count).