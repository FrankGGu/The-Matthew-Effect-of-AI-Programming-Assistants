-module(maximum_depth_n_ary_tree).
-export([max_depth/1]).

-record(node, {val, children}).

max_depth(Node) ->
  max_depth(Node, 0).

max_depth(null, Depth) ->
  Depth;
max_depth(Node, Depth) ->
  case Node of
    null ->
      Depth;
    #node{children = Children} ->
      lists:foldl(fun(Child, MaxDepth) ->
                      max(MaxDepth, max_depth(Child, Depth + 1))
                  end, Depth + 1, Children);
    _ ->
      Depth + 1
  end.