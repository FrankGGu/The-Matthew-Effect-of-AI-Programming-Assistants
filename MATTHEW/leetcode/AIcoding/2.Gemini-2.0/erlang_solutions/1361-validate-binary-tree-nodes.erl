-module(validate_binary_tree_nodes).
-export([validateBinaryTreeNodes/3]).

validateBinaryTreeNodes(N, LeftChild, RightChild) ->
  Roots = find_roots(N, LeftChild, RightChild),
  case length(Roots) of
    1 ->
      Root = lists:nth(1, Roots),
      Visited = dfs(Root, LeftChild, RightChild, []),
      length(Visited) =:= N;
    _ ->
      false
  end.

find_roots(N, LeftChild, RightChild) ->
  Children = LeftChild ++ RightChild,
  lists:subtract(lists:seq(0, N - 1), Children).

dfs(Node, LeftChild, RightChild, Visited) ->
  case lists:member(Node, Visited) of
    true ->
      Visited;
    false ->
      NewVisited = [Node | Visited],
      Left = lists:nth(Node + 1, LeftChild),
      Right = lists:nth(Node + 1, RightChild),
      NewVisited1 = case Left of
        -1 -> NewVisited;
        _ -> dfs(Left, LeftChild, RightChild, NewVisited)
      end,
      case Right of
        -1 -> NewVisited1;
        _ -> dfs(Right, LeftChild, RightChild, NewVisited1)
      end
  end.