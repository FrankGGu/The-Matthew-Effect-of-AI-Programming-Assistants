-module(queensAttacktheKing).
-export([queensAttacktheKing/2]).

queensAttacktheKing(Queens, King) ->
  queensAttacktheKing(Queens, King, []).

queensAttacktheKing([], _, Acc) ->
  lists:reverse(Acc);
queensAttacktheKing([Queen | Rest], King, Acc) ->
  DiffX = Queen[1] - King[1],
  DiffY = Queen[2] - King[2],
  case
    DiffX == 0 andalso DiffY > 0 ->
      queensAttacktheKing(Rest, King, maybeAddQueen(Queen, King, Acc, up));
    DiffX == 0 andalso DiffY < 0 ->
      queensAttacktheKing(Rest, King, maybeAddQueen(Queen, King, Acc, down));
    DiffX > 0 andalso DiffY == 0 ->
      queensAttacktheKing(Rest, King, maybeAddQueen(Queen, King, Acc, right));
    DiffX < 0 andalso DiffY == 0 ->
      queensAttacktheKing(Rest, King, maybeAddQueen(Queen, King, Acc, left));
    DiffX == DiffY andalso DiffX > 0 ->
      queensAttacktheKing(Rest, King, maybeAddQueen(Queen, King, Acc, upRight));
    DiffX == DiffY andalso DiffX < 0 ->
      queensAttacktheKing(Rest, King, maybeAddQueen(Queen, King, Acc, downLeft));
    DiffX + DiffY == 0 andalso DiffX > 0 ->
      queensAttacktheKing(Rest, King, maybeAddQueen(Queen, King, Acc, downRight));
    DiffX + DiffY == 0 andalso DiffX < 0 ->
      queensAttacktheKing(Rest, King, maybeAddQueen(Queen, King, Acc, upLeft));
    true ->
      queensAttacktheKing(Rest, King, Acc)
  end.

maybeAddQueen(Queen, King, Acc, Direction) ->
  case lists:keyfind(Direction, 1, Acc) of
    false ->
      [ {Direction, Queen} | Acc ];
    {_, ExistingQueen} ->
      Dist1 = distance(Queen, King),
      Dist2 = distance(ExistingQueen, King),
      if
        Dist1 < Dist2 ->
          lists:keyreplace(Direction, 1, Acc, {Direction, Queen});
        true ->
          Acc
      end
  end.

distance(Point1, Point2) ->
  math:sqrt(math:pow(Point1[1] - Point2[1], 2) + math:pow(Point1[2] - Point2[2], 2)).