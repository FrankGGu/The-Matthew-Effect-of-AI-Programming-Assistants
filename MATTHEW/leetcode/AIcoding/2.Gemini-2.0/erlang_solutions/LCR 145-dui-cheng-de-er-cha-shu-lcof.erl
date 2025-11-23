-module(symmetric_tree).
-export([is_symmetric/1]).

is_symmetric(Root) ->
  is_mirror(Root, Root).

is_mirror(Node1, Node2) ->
  case {Node1, Node2} of
    {null, null} ->
      true;
    {null, _} ->
      false;
    {_, null} ->
      false;
    {tree(Val1, Left1, Right1), tree(Val2, Left2, Right2)} ->
      Val1 =:= Val2 andalso is_mirror(Left1, Right2) andalso is_mirror(Right1, Left2);
    _ ->
      false
  end.

tree(Val, Left, Right) ->
    {tree, Val, Left, Right}.

null ->
    null.