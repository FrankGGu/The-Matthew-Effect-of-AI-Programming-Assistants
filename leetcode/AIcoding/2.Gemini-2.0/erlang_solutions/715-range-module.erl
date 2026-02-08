-module(range_module).
-export([new/0, add_range/2, query_range/2, remove_range/2]).

new() ->
  {tree, gb_sets:empty()}.

add_range({tree, Tree}, Left, Right) ->
  {NewTree, _} = add(Tree, Left, Right),
  {tree, NewTree}.

query_range({tree, Tree}, Left, Right) ->
  query(Tree, Left, Right).

remove_range({tree, Tree}, Left, Right) ->
  {NewTree, _} = remove(Tree, Left, Right),
  {tree, NewTree}.

add(Tree, Left, Right) ->
  {LeftNodes, RightNodes} = split(Tree, Left, Right),
  NewTree = gb_sets:add({Left, Right}, LeftNodes),
  {gb_sets:union(NewTree, RightNodes), true}.

remove(Tree, Left, Right) ->
  {LeftNodes, RightNodes} = split(Tree, Left, Right),
  RemovedTree = gb_sets:fold(fun({L, R}, Acc) ->
                                  case (L < Left) and (R > Right) of
                                    true ->
                                      Acc1 = gb_sets:add({L, Left}, Acc),
                                      gb_sets:add({Right, R}, Acc1);
                                    false ->
                                      case (L < Left) and (R =< Right) of
                                        true ->
                                          gb_sets:add({L, Left}, Acc);
                                        false ->
                                          case (L >= Left) and (R > Right) of
                                            true ->
                                              gb_sets:add({Right, R}, Acc);
                                            false ->
                                              Acc
                                          end
                                      end
                                  end
                              end, gb_sets:empty(), LeftNodes),
  {gb_sets:union(RemovedTree, RightNodes), true}.

split(Tree, Left, Right) ->
  {LeftNodes, MidNodes} = gb_sets:partition(fun({L, R}) -> R <= Left end, Tree),
  {MidNodes1, RightNodes} = gb_sets:partition(fun({L, R}) -> L >= Right end, MidNodes),
  {MidNodes, RightNodes} = merge(MidNodes1, RightNodes, Left, Right),

  {MidNodes, RightNodes}.

merge(MidNodes1, RightNodes, Left, Right) ->
  MidNodes = gb_sets:filter(fun({L, R}) -> (L < Right) and (R > Left) end, MidNodes1),
  {MidNodes, RightNodes}.

query(Tree, Left, Right) ->
  gb_sets:any(fun({L, R}) -> (L =< Left) and (R >= Right) end, Tree).