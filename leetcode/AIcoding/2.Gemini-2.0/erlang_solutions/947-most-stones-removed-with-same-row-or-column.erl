-module(most_stones).
-export([removeStones/1]).

removeStones(Stones) ->
  {Size, UnionFind} = lists:foldl(
    fun([X, Y], {S, UF}) ->
      Key = X * 10000 + Y,
      {S + 1, uf_union(X, Y + 10000, UF)}
    end,
    {0, uf_init()},
    Stones
  ),
  Components = sets:size(uf_components(UnionFind)),
  Size - Components.

uf_init() ->
  #{}.

uf_find(X, UF) ->
  case maps:get(X, UF, X) of
    X -> X;
    Parent ->
      Root = uf_find(Parent, UF),
      maps:put(X, Root, UF)
  end.

uf_union(X, Y, UF) ->
  RootX = uf_find(X, UF),
  RootY = uf_find(Y, UF),
  if RootX == RootY then
    UF
  else
    maps:put(RootX, RootY, UF)
  end.

uf_components(UF) ->
  sets:from_list([uf_find(K, UF) || K <- maps:keys(UF)]).