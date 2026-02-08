-module(inorder_successor).
-export([inorderSucc/2]).

inorderSucc(Root, P) ->
  inorderSuccHelper(Root, P, null).

inorderSuccHelper(null, _, Acc) ->
  Acc;
inorderSuccHelper(Node, P, Acc) ->
  case Node of
    {val, Value, Left, Right} ->
      case Value > P of
        true ->
          inorderSuccHelper(Left, P, {val, Value, Left, Right});
        false ->
          inorderSuccHelper(Right, P, Acc)
      end;
    _ ->
      Acc
  end.