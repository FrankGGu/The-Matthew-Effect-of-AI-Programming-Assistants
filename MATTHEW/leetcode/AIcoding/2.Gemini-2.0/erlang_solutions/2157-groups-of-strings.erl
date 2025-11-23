-module(groups_of_strings).
-export([num_similar_groups/1]).

num_similar_groups(strs) ->
  N = length(strs),
  UF = uf_init(N),
  for(I, 1, N,
    for(J, I+1, N,
      if
        similar(lists:nth(I, strs), lists:nth(J, strs)) ->
          uf_union(UF, I, J);
        true ->
          ok
      end
    )
  ),
  lists:foldl(fun(E, Acc) ->
    case uf_find(UF, E) of
      E -> Acc + 1;
      _ -> Acc
    end
  end, 0, lists:seq(1, N)).

similar(S1, S2) ->
  Diff = lists:zipwith(fun(C1, C2) -> if C1 /= C2 -> 1 else 0 end, S1, S2),
  lists:sum(Diff) =< 2.

uf_init(N) ->
  lists:seq(1, N).

uf_find(UF, I) ->
  case lists:nth(I, UF) of
    I ->
      I;
    Parent ->
      Root = uf_find(UF, Parent),
      uf_update(UF, I, Root)
  end.

uf_union(UF, I, J) ->
  RootI = uf_find(UF, I),
  RootJ = uf_find(UF, J),
  if RootI /= RootJ ->
    uf_update(UF, RootI, RootJ)
  else
    ok
  end.

uf_update(UF, I, Root) ->
  lists:map(fun(X) ->
    case X of
      {I, _} -> {I, Root};
      Y -> Y
    end
  end, lists:zip(lists:seq(1, length(UF)), UF)).

for(Var, Start, End, Body) ->
  for(Var, Start, End, 1, Body).

for(Var, Start, End, Step, Body) ->
  for(Var, Start, End, Step, Body, ok).

for(Var, Start, End, Step, Body, Acc) when Start =< End, Step > 0 ->
  NewAcc = Body,
  for(Var, Start + Step, End, Step, Body, NewAcc);
for(_, _, _, _, _, Acc) ->
  Acc.