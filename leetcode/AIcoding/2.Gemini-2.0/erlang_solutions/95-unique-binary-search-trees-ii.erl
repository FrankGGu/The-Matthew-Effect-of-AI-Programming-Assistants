-module(unique_bst).
-export([generateTrees/1]).

generateTrees(N) ->
  generateTrees(1, N).

generateTrees(Start, End) when Start > End ->
  [null];
generateTrees(Start, End) ->
  [
    {Root, Left, Right}
   || Root <- lists:seq(Start, End),
      Left <- generateTrees(Start, Root - 1),
      Right <- generateTrees(Root + 1, End)
  ].