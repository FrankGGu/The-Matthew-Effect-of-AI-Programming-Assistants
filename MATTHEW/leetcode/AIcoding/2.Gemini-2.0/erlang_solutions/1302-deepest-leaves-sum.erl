-module(deepest_leaves_sum).
-export([deepest_leaves_sum/1]).

-spec deepest_leaves_sum(TreeNode()) -> integer().

deepest_leaves_sum(Root) ->
  {_, Sum} = deepest_leaves_sum(Root, 0, 0, 0),
  Sum.

deepest_leaves_sum(nil, Level, MaxDepth, Sum) ->
  {MaxDepth, Sum};
deepest_leaves_sum({Val, Left, Right}, Level, MaxDepth, Sum) ->
  NewLevel = Level + 1,
  {MaxLeft, SumLeft} = deepest_leaves_sum(Left, NewLevel, MaxDepth, Sum),
  {MaxRight, SumRight} = deepest_leaves_sum(Right, NewLevel, MaxDepth, Sum),

  case MaxLeft > MaxRight of
    true ->
      case MaxLeft > NewLevel of
        true ->
          {MaxLeft, SumLeft};
        false ->
          case MaxLeft == NewLevel of
            true ->
              {NewLevel, SumLeft + Val};
            false ->
              {NewLevel, Val}
          end
      end;
    false ->
      case MaxRight > NewLevel of
        true ->
          {MaxRight, SumRight};
        false ->
          case MaxRight == NewLevel of
            true ->
              {NewLevel, SumRight + Val};
            false ->
              {NewLevel, Val}
          end
      end
  end.