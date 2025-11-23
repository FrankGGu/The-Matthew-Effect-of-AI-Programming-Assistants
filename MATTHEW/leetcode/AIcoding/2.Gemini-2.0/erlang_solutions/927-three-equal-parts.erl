-module(three_equal_parts).
-export([threeEqualParts/1]).

threeEqualParts(A) ->
  case lists:sum(A) of
    0 -> [0, 2];
    Sum when Sum rem 3 /= 0 -> [-1, -1];
    Sum ->
      Target := Sum div 3,
      {I1, I2, I3} = findIndices(A, Target),
      Len := length(A) - I3,
      if I1 + Len > I2 orelse I2 + Len > I3 orelse not lists:sublist(A, I1 + 1, Len) =:= lists:sublist(A, I2 + 1, Len) orelse not lists:sublist(A, I1 + 1, Len) =:= lists:sublist(A, I3 + 1, Len) then
        [-1, -1]
      else
        [I1 + Len - 1, I2 + Len]
      end
  end.

findIndices(A, Target) ->
  findIndicesHelper(A, Target, 0, 0, [], 0).

findIndicesHelper([], _, _, _, Acc, _) ->
  lists:reverse(Acc);
findIndicesHelper(A, Target, Count, Index, Acc, PrevIndex) ->
  case lists:nth(Index + 1, A) of
    1 ->
      NewCount := Count + 1,
      if NewCount =:= Target then
        findIndicesHelper(A, Target, NewCount, Index + 1, [Index | Acc], Index)
      else
        findIndicesHelper(A, Target, NewCount, Index + 1, Acc, PrevIndex)
      end;
    _ ->
      findIndicesHelper(A, Target, Count, Index + 1, Acc, PrevIndex)
  end.