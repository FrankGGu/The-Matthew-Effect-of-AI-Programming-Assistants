-module(binary_tree_coloring_game).
-export([btreeGameWinningMove/3]).

-record(tree, {val, left, right}).

btreeGameWinningMove(Root, N, X) ->
  {LeftSize, RightSize} = count_nodes(Root, X),
  ParentSize = N - LeftSize - RightSize - 1,
  max(ParentSize, max(LeftSize, RightSize)) > N div 2.

count_nodes(null, _) ->
  {0, 0};
count_nodes(#tree{val = Val, left = Left, right = Right}, X) ->
  case Val =:= X of
    true ->
      {count_nodes(Left, 0), count_nodes(Right, 0)};
    false ->
      {LeftSize, RightSize} =
        case Left of
          null -> {0, 0};
          _ -> count_nodes(Left, X)
        end,
      {LSize, RSize} =
        case Right of
          null -> {0, 0};
          _ -> count_nodes(Right, X)
        end,
      {LeftSize + LSize + (if Val == X -> 0; true -> 1 end), RightSize + RSize + (if Val == X -> 0; true -> 1 end)}
  end.

count_nodes(Node, X) when is_integer(Node) -> {0,0};
count_nodes(Node,X) ->
  case Node of
    null -> {0,0};
    _ ->
      Val = maps:get(val,Node),
      Left = maps:get(left,Node,null),
      Right = maps:get(right,Node,null),
      case Val =:= X of
        true ->
          {count_nodes(Left, 0), count_nodes(Right, 0)};
        false ->
          {LeftSize, RightSize} =
            case Left of
              null -> {0, 0};
              _ -> count_nodes(Left, X)
            end,
          {LSize, RSize} =
            case Right of
              null -> {0, 0};
              _ -> count_nodes(Right, X)
            end,
          {LeftSize + LSize + 1, RightSize + RSize + 1}
      end
  end.