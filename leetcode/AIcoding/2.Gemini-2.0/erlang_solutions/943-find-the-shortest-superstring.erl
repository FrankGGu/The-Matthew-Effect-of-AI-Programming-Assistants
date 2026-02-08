-module(shortest_superstring).
-export([shortestSuperstring/1]).

shortestSuperstring(A) ->
  N = length(A),
  Adj = createAdjMatrix(A),
  {Path, Len} = tsp(Adj, N),
  buildSuperstring(A, Path, Adj).

createAdjMatrix(A) ->
  N = length(A),
  Adj = lists:duplicate(N, lists:duplicate(N, 0)),
  createAdjMatrixHelper(A, Adj, N, 0, 0).

createAdjMatrixHelper(_, Adj, _, N, _) when N =< 0 ->
  Adj;
createAdjMatrixHelper(A, Adj, N, I, J) when I >= N ->
  createAdjMatrixHelper(A, Adj, N, 0, J + 1);
createAdjMatrixHelper(A, Adj, N, I, J) when J >= N ->
  Adj;
createAdjMatrixHelper(A, Adj, N, I, J) ->
  if
    I == J ->
      createAdjMatrixHelper(A, Adj, N, I + 1, J);
    true ->
      Overlap = calculateOverlap(lists:nth(I + 1, A), lists:nth(J + 1, A)),
      Adj1 = lists:nth(I + 1, Adj),
      Adj2 = lists:nth(I + 1, lists:substitute(J + 1, lists:nth(J + 1, Adj1), Overlap, Adj)),
      createAdjMatrixHelper(A, Adj2, N, I + 1, J)
  end.

calculateOverlap(S1, S2) ->
  N1 = length(S1),
  N2 = length(S2),
  calculateOverlapHelper(S1, S2, N1, N2, 0).

calculateOverlapHelper(S1, S2, N1, N2, Overlap) when Overlap >= N1 orelse Overlap >= N2 ->
  Overlap;
calculateOverlapHelper(S1, S2, N1, N2, Overlap) ->
  Sub1 = string:sub_string(S1, N1 - Overlap, Overlap),
  Sub2 = string:sub_string(S2, 1, Overlap),
  if
    Sub1 == Sub2 ->
      calculateOverlapHelper(S1, S2, N1, N2, Overlap + 1);
    true ->
      calculateOverlapHelper(S1, S2, N1, N2, Overlap + 1)
  end.

tsp(Adj, N) ->
  tspHelper(Adj, N, 1, lists:seq(2, N), [1], 0, {[], 1000000}).

tspHelper(_, _, _, [], Path, Len, Best) ->
  {Path1, Len1} = Best,
  Last = lists:last(Path),
  First = lists:nth(1, Path),
  LenToFirst = lists:nth(First, lists:nth(Last, Adj)),
  NewLen = Len + lists:nth(First, lists:nth(Last, Adj)),

  if
    NewLen < Len1 ->
      {lists:reverse(Path), NewLen};
    true ->
      Best
  end;
tspHelper(Adj, N, Node, Remaining, Path, Len, Best) ->
  lists:foldl(
    fun (Next, Acc) ->
      {PathAcc, LenAcc} = Acc,
      Last = lists:last(Path),
      NewLen = Len + lists:nth(Next, lists:nth(Last, Adj)),

      tspHelper(Adj, N, Next, lists:delete(Next, Remaining), [Next | Path], NewLen, Acc)
    end,
    Best,
    Remaining
  ).

buildSuperstring(A, Path, Adj) ->
  buildSuperstringHelper(A, Path, Adj, lists:nth(1, Path), tl(Path), lists:nth(lists:nth(1, Path), A), "").

buildSuperstringHelper(A, _, _, _, [], Acc, Result) ->
  Result;
buildSuperstringHelper(A, Path, Adj, Prev, [Next | Rest], Acc, Result) ->
  Overlap = lists:nth(Next, lists:nth(Prev, Adj)),
  NextStr = lists:nth(Next, A),
  Suffix = string:sub_string(NextStr, Overlap + 1, length(NextStr) - Overlap),
  buildSuperstringHelper(A, Path, Adj, Next, Rest, Acc, Result ++ Suffix).