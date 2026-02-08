-module(right_side_view).
-export([right_side_view/1]).

right_side_view(Root) ->
  right_side_view(Root, []).

right_side_view(Root, Acc) ->
  levels(Root, 0, [], Levels),
  lists:map(fun(L) -> lists:last(L) end, Levels).

levels(null, _, Acc, Acc) -> Acc;
levels(TreeNode, Level, Acc, Out) ->
  Val = element(1, TreeNode),
  Left = element(2, TreeNode),
  Right = element(3, TreeNode),

  NewAcc =
    case lists:nth(Level + 1, Acc, null) of
      null ->
        lists:sublist(Acc, 1, Level) ++ [ [Val] ] ++ lists:droplast(lists:seq(Level+1, length(Acc)));
      _ ->
        lists:sublist(Acc, 1, Level) ++ [ lists:nth(Level + 1, Acc) ++ [Val] ] ++ lists:droplast(lists:seq(Level+1, length(Acc)))
    end,

  levels(Left, Level + 1, NewAcc, Acc1),
  levels(Right, Level + 1, Acc1, Out).