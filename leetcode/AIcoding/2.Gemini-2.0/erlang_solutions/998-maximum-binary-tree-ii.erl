-module(maximum_binary_tree_ii).
-export([insert_into_max_tree/2]).

-type tree_node() :: {integer(), tree_node(), tree_node()} | nil.

insert_into_max_tree(Root, Val) ->
  insert(Root, Val).

insert(nil, Val) ->
  {Val, nil, nil};
insert({RootVal, Left, Right}, Val) when Val > RootVal ->
  {Val, {RootVal, Left, Right}, nil};
insert({RootVal, Left, Right}, Val) ->
  {RootVal, Left, insert(Right, Val)}.