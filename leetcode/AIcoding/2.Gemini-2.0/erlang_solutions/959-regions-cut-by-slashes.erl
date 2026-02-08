-module(regions_cut_by_slashes).
-export([num_region::(list(string()) -> integer())]).

num_region(grid) ->
  N = length(grid),
  Size = N + 1,
  UF = uf_init(Size * Size),

  lists:foreach(fun(RowIdx) ->
                  lists:foreach(fun(ColIdx) ->
                                  Char = string:substr(lists:nth(RowIdx, grid), ColIdx, 1),
                                  case Char of
                                    " " -> ok;
                                    "/" ->
                                      uf_union(UF, (RowIdx - 1) * Size + ColIdx, (RowIdx) * Size + (ColIdx - 1));
                                    "\\" ->
                                      uf_union(UF, (RowIdx - 1) * Size + (ColIdx - 1), (RowIdx) * Size + ColIdx)
                                  end
                                 end, lists:seq(1, N))
                 end, lists:seq(1, N)),

  NumComponents = uf_count_components(UF, Size * Size),
  NumComponents.

uf_init(N) ->
  {lists:seq(1, N), lists:duplicate(N, 1)}.

uf_find(UF, X) ->
  {Parents, _Sizes} = UF,
  uf_find_helper(Parents, X).

uf_find_helper(Parents, X) ->
  case lists:nth(X, Parents) of
    X ->
      X;
    Parent ->
      Root = uf_find_helper(Parents, Parent),
      Parents2 = lists:nth_replace(X, Root, Parents),
      Root
  end.

uf_union({Parents, Sizes}, X, Y) ->
  RootX = uf_find({Parents, Sizes}, X),
  RootY = uf_find({Parents, Sizes}, Y),
  if RootX == RootY ->
    {Parents, Sizes}
  else
    {Parents2, Sizes2} = uf_union_helper({Parents, Sizes}, RootX, RootY),
    {Parents2, Sizes2}
  end.

uf_union_helper({Parents, Sizes}, RootX, RootY) ->
  SizeX = lists:nth(RootX, Sizes),
  SizeY = lists:nth(RootY, Sizes),
  if SizeX < SizeY ->
    Parents2 = lists:nth_replace(RootX, RootY, Parents),
    Sizes2 = lists:nth_replace(RootY, SizeX + SizeY, Sizes),
    {Parents2, Sizes2}
  else
    Parents2 = lists:nth_replace(RootY, RootX, Parents),
    Sizes2 = lists:nth_replace(RootX, SizeX + SizeY, Sizes),
    {Parents2, Sizes2}
  end.

uf_count_components({Parents, _Sizes}, N) ->
  lists:foldl(fun(X, Acc) ->
                  Root = uf_find_helper(Parents, X),
                  case lists:member(Root, Acc) of
                    true -> Acc;
                    false -> [Root | Acc]
                  end
              end, [], lists:seq(1, N)),
  length(lists:foldl(fun(X, Acc) ->
                  Root = uf_find_helper(Parents, X),
                  case lists:member(Root, Acc) of
                    true -> Acc;
                    false -> [Root | Acc]
                  end
              end, [], lists:seq(1, N))).