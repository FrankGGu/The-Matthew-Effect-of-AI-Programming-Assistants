-module(insert_into_bst).
-export([insertIntoBST/2]).

-spec insertIntoBST(Tree :: tree(), Val :: integer()) -> tree().

insertIntoBST(null, Val) ->
    {Val, null, null};
insertIntoBST({Val, Left, Right}, Val) ->
    {Val, Left, Right};
insertIntoBST({Val, Left, Right}, NewVal) when NewVal < Val ->
    {Val, insertIntoBST(Left, NewVal), Right};
insertIntoBST({Val, Left, Right}, NewVal) when NewVal > Val ->
    {Val, Left, insertIntoBST(Right, NewVal), Right}.

-type tree() :: null | {integer(), tree(), tree()}.