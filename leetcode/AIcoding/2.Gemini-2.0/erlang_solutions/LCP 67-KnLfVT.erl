-module(decorateTree).
-export([solve/1]).

-spec solve(Tree :: tree()) -> tree().
solve(Tree) ->
  decorate(Tree, 1).

-type tree() :: {integer(), tree(), tree()} | nil.

decorate(nil, _) ->
  nil;
decorate({Val, Left, Right}, Depth) ->
  {Val + Depth, decorate(Left, Depth + 1), decorate(Right, Depth + 1)}.