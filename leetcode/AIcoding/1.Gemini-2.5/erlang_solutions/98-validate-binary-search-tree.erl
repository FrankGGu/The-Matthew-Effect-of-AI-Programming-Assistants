-module(solution).
-export([is_valid_bst/1]).

-define(NEG_INF, -2147483649). % A value strictly less than -2^31
-define(POS_INF, 2147483648).  % A value strictly greater than 2^31 - 1

is_valid_bst(Root) ->
    is_valid_bst_helper(Root, ?NEG_INF, ?POS_INF).

is_valid_bst_helper(null, _Min, _Max) ->
    true;
is_valid_bst_helper({Val, Left, Right}, Min, Max) ->
    Val > Min andalso Val < Max andalso
    is_valid_bst_helper(Left, Min, Val) andalso
    is_valid_bst_helper(Right, Val, Max).