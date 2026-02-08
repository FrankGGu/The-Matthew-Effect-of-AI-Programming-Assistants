-module(trim_bst).
-export([trimBST/3]).

trimBST(Tree, Low, High) ->
    trim(Tree, Low, High).

trim(nil, _, _) ->
    nil;
trim({Val, Left, Right}, Low, High) ->
    if
        Val < Low ->
            trim(Right, Low, High);
        Val > High ->
            trim(Left, Low, High);
        true ->
            {Val, trim(Left, Low, High), trim(Right, Low, High)}
    end.