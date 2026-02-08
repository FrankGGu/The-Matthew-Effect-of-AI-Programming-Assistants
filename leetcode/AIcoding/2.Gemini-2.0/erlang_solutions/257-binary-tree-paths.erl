-module(binary_tree_paths).
-export([binaryTreePaths/1]).

binaryTreePaths(Root) ->
  paths(Root, []).

paths(null, Acc) ->
  case Acc of
    [] -> [];
    _ -> [lists:reverse(Acc)]
  end;
paths(Node, Acc) ->
  Val = Node#tree.val,
  NewAcc = [integer_to_list(Val) | Acc],
  LeftPaths = paths(Node#tree.left, NewAcc),
  RightPaths = paths(Node#tree.right, NewAcc),
  format_paths(LeftPaths ++ RightPaths).

format_paths(Paths) ->
  lists:map(fun(Path) -> string:join(Path, "->") end, Paths).

-record(tree, {val, left, right}).