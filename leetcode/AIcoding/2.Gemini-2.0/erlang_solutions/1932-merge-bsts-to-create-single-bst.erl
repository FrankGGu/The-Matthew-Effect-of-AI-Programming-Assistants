-module(merge_bsts).
-export([can_merge/1]).

can_merge(Trees) ->
  case Trees of
    [] ->
      null;
    _ ->
      Nodes = lists:map(fun(Tree) -> get_nodes(Tree, []) end, Trees),
      AllNodes = lists:flatten(Nodes),
      Roots = lists:map(fun(Tree) -> get_root(Tree) end, Trees),
      AllValues = lists:map(fun(Node) -> node_val(Node) end, AllNodes),
      ValueCounts = lists:foldl(fun(V, Acc) ->
                                    case maps:is_key(V, Acc) of
                                      true ->
                                        maps:update(V, maps:get(V, Acc) + 1, Acc);
                                      false ->
                                        maps:put(V, 1, Acc)
                                    end
                                 end, #{}, AllValues),

      RootCandidates = lists:filter(fun(Root) ->
                                       Val = node_val(Root),
                                       maps:get(Val, ValueCounts) == 1
                                    end, Roots),

      case RootCandidates of
        [Root] ->
          RemainingTrees = lists:filter(fun(Tree) ->
                                            get_root(Tree) /= Root
                                         end, Trees),
          Merged = merge_helper(Root, RemainingTrees),
          case is_bst(Merged, -infinity, infinity) of
            true ->
              case lists:sort(AllValues) =:= lists:sort(get_all_values(Merged, [])) of
                true ->
                  Merged;
                false ->
                  null
              end;
            false ->
              null
          end;
        _ ->
          null
      end
  end.

get_nodes(null, Acc) ->
  Acc;
get_nodes({val, _, _, _} = Node, Acc) ->
  get_nodes(node_left(Node), [Node | Acc]) ++ get_nodes(node_right(Node), [Node | Acc]).

get_root({val, V, L, R}) ->
  {val, V, L, R}.

node_val({val, V, _, _}) ->
  V.

node_left({val, _, L, _}) ->
  L.

node_right({val, _, _, R}) ->
  R.

set_left({val, V, _, R}, NewLeft) ->
  {val, V, NewLeft, R}.

set_right({val, V, L, _}, NewRight) ->
  {val, V, L, NewRight}.

merge_helper(Root, []) ->
  Root;
merge_helper(Root, [Tree | Rest]) ->
  NewRoot = merge_one(Root, Tree),
  merge_helper(NewRoot, Rest).

merge_one(Root, Tree) ->
  Val = node_val(Tree),
  case find_and_replace(Root, Val, Tree) of
    {found, UpdatedRoot} ->
      UpdatedRoot;
    not_found ->
      Root
  end.

find_and_replace(null, _, _) ->
  not_found;
find_and_replace({val, V, L, R} = Node, ValToReplace, Replacement) ->
  case V of
    ValToReplace ->
      {found,
       case node_val(Replacement) < V of
         true ->
           set_left(Node, Replacement);
         false ->
           set_right(Node, Replacement)
       end};
    _ ->
      case find_and_replace(L, ValToReplace, Replacement) of
        {found, NewLeft} ->
          {found, set_left(Node, NewLeft)};
        not_found ->
          case find_and_replace(R, ValToReplace, Replacement) of
            {found, NewRight} ->
              {found, set_right(Node, NewRight)};
            not_found ->
              not_found
          end
      end
  end.

is_bst(null, _, _) ->
  true;
is_bst({val, V, L, R}, Min, Max) ->
  case (V > Min) and (V < Max) of
    true ->
      is_bst(L, Min, V) and is_bst(R, V, Max);
    false ->
      false
  end.

get_all_values(null, Acc) ->
  Acc;
get_all_values({val, V, L, R}, Acc) ->
  get_all_values(L, [V | get_all_values(R, Acc)]).