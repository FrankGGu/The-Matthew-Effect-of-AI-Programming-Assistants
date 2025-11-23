-module(similar_string_groups).
-export([num_similar_groups/1]).

num_similar_groups(Strs) ->
  N = length(Strs),
  UF = uf_init(N),
  for(I, 1, N - 1,
    for(J, I + 1, N,
      if
        are_similar(lists:nth(I, Strs), lists:nth(J, Strs)) ->
          uf_union(UF, I, J);
        true ->
          ok
      end
    )
  ),
  uf_count(UF).

are_similar(S1, S2) ->
  case length(S1) of
    Len ->
      Diff = lists:foldl(
               fun(I, Acc) ->
                 case lists:nth(I, S1) =:= lists:nth(I, S2) of
                   true -> Acc;
                   false -> Acc + 1
                 end
               end,
               0,
               lists:seq(1, Len)
             ),
      Diff =< 2
  end.

uf_init(N) ->
  {lists:seq(1, N), lists:duplicate(N, 1)}.

uf_find({Parents, _}, I) ->
  case lists:nth(I, Parents) of
    I -> I;
    P ->
      Root = uf_find({Parents, _}, P),
      {lists:nth(I, Parents), Root} = {Root, Root},
      Root
  end.

uf_union({Parents, Sizes}, I, J) ->
  RootI = uf_find({Parents, Sizes}, I),
  RootJ = uf_find({Parents, Sizes}, J),
  if
    RootI =:= RootJ ->
      {Parents, Sizes};
    true ->
      {NewParents, NewSizes} =
        case lists:nth(RootI, Sizes) < lists:nth(RootJ, Sizes) of
          true ->
            {lists:replace_nth(RootI, RootJ, Parents),
             lists:replace_nth(RootJ, lists:nth(RootI, Sizes) + lists:nth(RootJ, Sizes), Sizes)};
          false ->
            {lists:replace_nth(RootJ, RootI, Parents),
             lists:replace_nth(RootI, lists:nth(RootI, Sizes) + lists:nth(RootJ, Sizes), Sizes)}
        end,
      {NewParents, NewSizes}
  end.

uf_count({Parents, _}) ->
  lists:foldl(
    fun(I, Acc) ->
      case lists:nth(I, Parents) =:= I of
        true -> Acc + 1;
        false -> Acc
      end
    end,
    0,
    lists:seq(1, length(Parents))
  ).

for(I, From, To, Body) ->
  for(I, From, To, Body, ok).

for(I, From, To, Body, Acc) ->
  if
    From > To ->
      Acc;
    true ->
      for(I, From + 1, To, Body, Body(I))
  end.