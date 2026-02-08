-module(make_connected).
-export([make_connected/2]).

make_connected(N, Connections) ->
  Len = length(Connections),
  if Len < N - 1 then
    -1
  else
    UF = uf_init(N),
    lists:foldl(fun({U, V}, Acc) -> uf_union(U, V, Acc) end, UF, Connections),
    NumComponents = uf_num_components(UF),
    NumComponents - 1
  end.

uf_init(N) ->
  {lists:seq(1, N), lists:seq(1, N), N}.

uf_find(X, {Parents, _, _}) ->
  find(X, Parents).

find(X, Parents) ->
  if X == lists:nth(X, Parents) then
    X
  else
    Root = find(lists:nth(X, Parents), Parents),
    lists:nth(X, Parents)
  end.

uf_union(U, V, {Parents, Ranks, Count}) ->
  RootU = uf_find(U, {Parents, Ranks, Count}),
  RootV = uf_find(V, {Parents, Ranks, Count}),
  if RootU == RootV then
    {Parents, Ranks, Count}
  else
    {NewParents, NewRanks, NewCount} = union(RootU, RootV, {Parents, Ranks, Count}),
    {NewParents, NewRanks, NewCount - 1}
  end.

union(RootU, RootV, {Parents, Ranks, Count}) ->
  RankU = lists:nth(RootU, Ranks),
  RankV = lists:nth(RootV, Ranks),
  if RankU < RankV then
    NewParents = lists:replace(RootU, RootV, Parents),
    {NewParents, Ranks, Count}
  elseif RankU > RankV then
    NewParents = lists:replace(RootV, RootU, Parents),
    {NewParents, Ranks, Count}
  else
    NewParents = lists:replace(RootV, RootU, Parents),
    NewRanks = lists:replace(RootU, RankU + 1, Ranks),
    {NewParents, NewRanks, Count}
  end.

uf_num_components({_, _, Count}) ->
  Count.