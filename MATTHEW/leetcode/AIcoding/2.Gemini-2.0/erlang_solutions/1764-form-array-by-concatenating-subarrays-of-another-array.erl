-module(find_array_concatenation).
-export([canFormArray/2]).

canFormArray(Arr, Pieces) ->
  canFormArray(Arr, Pieces, []).

canFormArray([], _, _Acc) ->
  true;
canFormArray(Arr, Pieces, Acc) ->
  case find_piece(Arr, Pieces) of
    {true, Piece} ->
      NewArr = lists:sublist(Arr, length(Piece) + 1, length(Arr) - length(Piece)),
      canFormArray(NewArr, Pieces, [Piece | Acc]);
    false ->
      false
  end.

find_piece(Arr, Pieces) ->
  find_piece(Arr, Pieces, []).

find_piece(Arr, [], _Acc) ->
  false;
find_piece(Arr, [Piece | Rest], Acc) ->
  case lists:prefix(Piece, Arr) of
    true ->
      {true, Piece};
    false ->
      find_piece(Arr, Rest, [Piece | Acc])
  end.