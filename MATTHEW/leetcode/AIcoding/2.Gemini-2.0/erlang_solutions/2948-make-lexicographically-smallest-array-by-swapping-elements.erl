-module(smallest_array).
-export([smallest_array/2]).

smallest_array(Nums, Limit) ->
  N = length(Nums),
  UF = uf_init(N),
  lists:foreach(
    fun(I) ->
      lists:foreach(
        fun(J) ->
          if
            abs(lists:nth(I, Nums) - lists:nth(J, Nums)) =< Limit ->
              uf_union(UF, I - 1, J - 1);
            true ->
              ok
          end
        end,
        lists:seq(I + 1, N)
      )
    end,
    lists:seq(1, N)
  ),

  Groups = lists:foldl(
    fun(I, Acc) ->
      Root = uf_find(UF, I - 1),
      case maps:is_key(Root, Acc) of
        true ->
          maps:update(Root, [I | maps:get(Root, Acc)], Acc);
        false ->
          maps:put(Root, [I], Acc)
      end
    end,
    #{},
    lists:seq(1, N)
  ),

  lists:foldl(
    fun({Root, Indices}, Res) ->
      Values = [lists:nth(I, Nums) || I <- Indices],
      SortedValues = lists:sort(Values),
      lists:foldl(
        fun({Index, Value}, Acc) ->
          lists:nth(Index, Acc) ! Value,
          Acc
        end,
        Res,
        lists:zip(Indices, SortedValues)
      )
    end,
    list_to_ref_array(Nums),
    maps:to_list(Groups)
  )
  .

list_to_ref_array(L) ->
  [element(1,erlang:make_ref()) || _ <- L].

-module(uf).
-export([uf_init/1, uf_find/2, uf_union/3]).

uf_init(N) ->
  #{
    parent => lists:seq(0, N - 1),
    rank => lists:duplicate(N, 0)
  }.

uf_find(UF, X) ->
  Parent = lists:nth(X + 1, maps:get(parent, UF)),
  if
    Parent == X ->
      X;
    true ->
      Root = uf_find(UF, Parent),
      maps:put(parent, update_nth(X + 1, Root, maps:get(parent, UF)), UF),
      Root
  end.

uf_union(UF, X, Y) ->
  RootX = uf_find(UF, X),
  RootY = uf_find(UF, Y),
  if
    RootX == RootY ->
      UF;
    true ->
      RankX = lists:nth(RootX + 1, maps:get(rank, UF)),
      RankY = lists:nth(RootY + 1, maps:get(rank, UF)),
      if
        RankX < RankY ->
          maps:put(parent, update_nth(RootX + 1, RootY, maps:get(parent, UF)), UF);
        RankX > RankY ->
          maps:put(parent, update_nth(RootY + 1, RootX, maps:get(parent, UF)), UF);
        true ->
          NewUF = maps:put(parent, update_nth(RootY + 1, RootX, maps:get(parent, UF)), UF),
          maps:put(rank, update_nth(RootX + 1, RankX + 1, maps:get(rank, NewUF)), NewUF)
      end
  end.

update_nth(N, Val, L) ->
  lists:prefix(N - 1, L) ++ [Val] ++ lists:nthtail(N, L).