-module(levelOrderBottom).
-export([levelOrderBottom/1]).

levelOrderBottom(Root) ->
  levelOrderBottomHelper(Root, []).

levelOrderBottomHelper(Root, Acc) ->
  Levels = levelOrder(Root, []),
  lists:reverse(Levels).

levelOrder(Root, Acc) ->
  levelOrderHelper([Root], [], Acc).

levelOrderHelper([], NextLevel, Acc) ->
  case NextLevel of
    [] -> lists:reverse(Acc);
    _  -> levelOrderHelper(NextLevel, [], [lists:map(fun(X) -> X#tree.val end, NextLevel) | Acc])
  end.

levelOrderHelper([Node | Rest], NextLevel, Acc) ->
  case Node of
    null -> levelOrderHelper(Rest, NextLevel, Acc);
    #tree{val = Val, left = Left, right = Right} ->
      levelOrderHelper(Rest, NextLevel ++ [Left, Right], Acc)
  end.

-record(tree, {val, left, right}).