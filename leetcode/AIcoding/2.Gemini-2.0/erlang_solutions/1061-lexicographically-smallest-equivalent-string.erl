-module(lexicographically_smallest_equivalent_string).
-export([smallestEquivalentString/3]).

smallestEquivalentString(S1, S2, BaseStr) ->
    UnionFind = init_union_find(),
    lists:foreach(fun({C1, C2}) ->
                          union(UnionFind, C1, C2)
                  end, lists:zip(S1, S2)),
    lists:map(fun(C) ->
                      find(UnionFind, C)
              end, BaseStr).

init_union_find() ->
    lists:map(fun(C) -> {C, C} end, lists:seq($a, $z)).

find(UnionFind, C) ->
    case lists:keyfind(C, 1, UnionFind) of
        {C, C} ->
            C;
        {C, Parent} ->
            Root = find(UnionFind, Parent),
            update_parent(UnionFind, C, Root)
    end.

union(UnionFind, C1, C2) ->
    Root1 = find(UnionFind, C1),
    Root2 = find(UnionFind, C2),
    case Root1 < Root2 of
        true ->
            update_parent(UnionFind, Root2, Root1);
        false ->
            update_parent(UnionFind, Root1, Root2)
    end.

update_parent(UnionFind, C, Parent) ->
    lists:foreach(fun(Elem) ->
                          case Elem of
                              {C, _} ->
                                  true;
                              _ ->
                                  false
                          end
                  end, UnionFind),
    NewUnionFind = lists:map(fun(Elem) ->
                                      case Elem of
                                          {C, _} ->
                                              {C, Parent};
                                          _ ->
                                              Elem
                                      end
                              end, UnionFind),
    NewUnionFind.