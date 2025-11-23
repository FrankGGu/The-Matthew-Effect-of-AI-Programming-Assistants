-module(solution).
-export([maxSum/1]).

-record(node, {value, left=none, right=none}).

maxSum(Root) ->
    max_sum(Root).

max_sum(none) ->
    0;
max_sum(#node{value=Value, left=Left, right=Right}) ->
    Value + max(max_sum(Left), max_sum(Right)).