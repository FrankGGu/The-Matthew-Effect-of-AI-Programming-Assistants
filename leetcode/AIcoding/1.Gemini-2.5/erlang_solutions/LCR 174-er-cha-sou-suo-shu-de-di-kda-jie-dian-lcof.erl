-module(solution).
-export([search_bst/2]).

search_bst(nil, _Val) ->
    nil;
search_bst({Val, Left, Right}, Val) ->
    {Val, Left, Right};
search_bst({NodeVal, Left, _Right}, Val) when Val < NodeVal ->
    search_bst(Left, Val);
search_bst({NodeVal, _Left, Right}, Val) when Val > NodeVal ->
    search_bst(Right, Val).