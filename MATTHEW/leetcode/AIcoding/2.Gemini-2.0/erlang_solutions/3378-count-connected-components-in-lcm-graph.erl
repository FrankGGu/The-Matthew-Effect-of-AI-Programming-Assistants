-module(lcm_graph).
-export([count_connected_components/1]).

count_connected_components(N) ->
  Uf = uf_init(N),
  [uf_union(Uf, I, J) || I <- lists:seq(1, N), J <- lists:seq(I + 1, N), lcm(I, J) =< N],
  length(lists:usort([uf_find(Uf, I) || I <- lists:seq(1, N)])).

lcm(A, B) ->
  (A * B) div gcd(A, B).

gcd(A, 0) -> A;
gcd(A, B) -> gcd(B, A rem B).

uf_init(N) ->
  {array:from_list(lists:seq(1, N)), array:from_list(lists:duplicate(N, 1))}.

uf_find({Parents, _Sizes}, I) ->
  uf_find_internal(Parents, I).

uf_find_internal(Parents, I) ->
  Parent = array:get(I, Parents),
  if
    Parent == I ->
      I;
    true ->
      Root = uf_find_internal(Parents, Parent),
      array:set(I, Root, Parents),
      Root
  end.

uf_union({Parents, Sizes}, I, J) ->
  RootI = uf_find({Parents, Sizes}, I),
  RootJ = uf_find({Parents, Sizes}, J),
  if
    RootI == RootJ ->
      {Parents, Sizes};
    true ->
      SizeI = array:get(RootI, Sizes),
      SizeJ = array:get(RootJ, Sizes),
      if
        SizeI < SizeJ ->
          NewParents = array:set(RootI, RootJ, Parents),
          NewSizes = array:set(RootJ, SizeI + SizeJ, Sizes),
          {NewParents, NewSizes};
        true ->
          NewParents = array:set(RootJ, RootI, Parents),
          NewSizes = array:set(RootI, SizeI + SizeJ, Sizes),
          {NewParents, NewSizes}
      end
  end.