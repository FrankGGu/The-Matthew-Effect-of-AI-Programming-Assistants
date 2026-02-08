-module(validate_binary_search_tree).
-export([isValidBST/1]).

-type tree() :: 'null' | {node, integer(), tree(), tree()}.

-spec isValidBST(tree()) -> boolean().
isValidBST(Tree) ->
    isValidBST(Tree, -2147483648, 2147483647).

isValidBST('null', _Min, _Max) ->
    true;
isValidBST({node, Val, Left, Right}, Min, Max) ->
    Val > Min andalso Val < Max andalso
    isValidBST(Left, Min, Val) andalso
    isValidBST(Right, Val, Max).