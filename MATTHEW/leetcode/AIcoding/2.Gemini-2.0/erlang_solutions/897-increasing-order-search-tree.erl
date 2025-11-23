-module(increasing_bst).
-export([increasing_bst/1]).

-spec increasing_bst(Tree :: tree()) -> tree().
increasing_bst(Root) ->
  increasing_bst(Root, nil).

increasing_bst(nil, Tail) ->
  Tail;
increasing_bst({Val, Left, Right}, Tail) ->
  increasing_bst(Left, {Val, nil, increasing_bst(Right, Tail)}).