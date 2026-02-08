-module(critical_pseudo_critical_edges).
-export([find_critical_and_pseudo_critical_edges/2]).

find_critical_and_pseudo_critical_edges(N, Edges) ->
  MSTWeight = mst_weight(N, Edges, -1, []),
  CriticalEdges = [I || {I, Edge} <- lists:zip(lists:seq(0, length(Edges) - 1), Edges), mst_weight(N, Edges, I, []) > MSTWeight],
  PseudoCriticalEdges = [I || {I, Edge} <- lists:zip(lists:seq(0, length(Edges) - 1), Edges),
                          lists:member(I, CriticalEdges) == false,
                          mst_weight(N, Edges, -1, [I]) == MSTWeight],
  [CriticalEdges, PseudoCriticalEdges].

mst_weight(N, Edges, ExcludeIndex, IncludeIndices) ->
  EdgesWithIndices = lists:zip(lists:seq(0, length(Edges) - 1), Edges),
  FilteredEdges = [ {W, U, V, I} || {I, {U, V, W}} <- EdgesWithIndices, I /= ExcludeIndex ],
  SortedEdges = lists:sort(fun({W1, _, _, _}, {W2, _, _, _}) -> W1 < W2 end, FilteredEdges),

  UF = uf_init(N),
  Weight = mst_weight_helper(UF, SortedEdges, IncludeIndices),
  if uf_count(UF) == 1 then
    Weight
  else
    infinity
  end.

mst_weight_helper(UF, [], _) ->
  0;
mst_weight_helper(UF, [{W, U, V, I} | Rest], IncludeIndices) ->
  case lists:member(I, IncludeIndices) of
    true ->
      if uf_find(UF, U) /= uf_find(UF, V) then
        uf_union(UF, U, V),
        W + mst_weight_helper(UF, Rest, IncludeIndices)
      else
        mst_weight_helper(UF, Rest, IncludeIndices)
      end;
    false ->
      if uf_find(UF, U) /= uf_find(UF, V) then
        uf_union(UF, U, V),
        W + mst_weight_helper(UF, Rest, IncludeIndices)
      else
        mst_weight_helper(UF, Rest, IncludeIndices)
      end
  end.

uf_init(N) ->
  {lists:seq(0, N - 1), lists:duplicate(N, 1), N}.

uf_find({Parents, _, _}, X) ->
  uf_find_recursive(Parents, X).

uf_find_recursive(Parents, X) ->
  case lists:nth(X + 1, Parents) of
    X ->
      X;
    Parent ->
      Root = uf_find_recursive(Parents, Parent),
      lists:nth(X + 1, lists:substitute(Parent, Root, Parents)),
      Root
  end.

uf_union(UF = {Parents, Ranks, Count}, X, Y) ->
  RootX = uf_find(UF, X),
  RootY = uf_find(UF, Y),
  if RootX == RootY then
    UF
  else
    {NewParents, NewRanks, NewCount} = uf_union_by_rank(Parents, Ranks, RootX, RootY),
    {NewParents, NewRanks, NewCount - 1}
  end.

uf_union_by_rank(Parents, Ranks, RootX, RootY) ->
  RankX = lists:nth(RootX + 1, Ranks),
  RankY = lists:nth(RootY + 1, Ranks),
  case RankX < RankY of
    true ->
      NewParents = lists:nth(RootX + 1, lists:substitute(RootX, RootY, Parents)),
      {NewParents, Ranks, length(Parents)};
    false ->
      NewParents = lists:nth(RootY + 1, lists:substitute(RootY, RootX, Parents)),
      NewRanks = if RankX == RankY then
                   lists:nth(RootX + 1, lists:substitute(RankX, RankX + 1, Ranks))
                 else
                   Ranks
                 end,
      {NewParents, NewRanks, length(Parents)}
  end.

uf_count({_, _, Count}) ->
  Count.

infinity ->
  1000000000.