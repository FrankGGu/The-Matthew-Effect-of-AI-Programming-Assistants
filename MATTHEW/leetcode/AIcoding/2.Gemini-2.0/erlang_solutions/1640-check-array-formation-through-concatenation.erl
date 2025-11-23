-module(check_array_formation).
-export([can_form_array/2]).

can_form_array(Arr, Pieces) ->
  can_form_array(Arr, Pieces, []).

can_form_array([], _, _) ->
  true;
can_form_array(_Arr, [], _) ->
  false;
can_form_array(Arr, [Piece | RestPieces], Visited) ->
  case lists:prefix(Piece, Arr) of
    true ->
      NewArr = lists:sublist(Arr, length(Piece) + 1, length(Arr) - length(Piece)),
      can_form_array(NewArr, lists:delete(Piece, RestPieces), Visited);
    false ->
      can_form_array(Arr, RestPieces, Visited)
  end.