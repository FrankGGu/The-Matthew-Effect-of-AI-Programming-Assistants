-module(subtree_inversion_sum).
-export([inversionSum/1]).

-record(node, {val, left, right}).

inversionSum(undefined) -> 0;
inversionSum(Node) ->
    invert(Node),
    sumNodes(Node).

invert(undefined) -> undefined;
invert(#node{val=Val, left=Left, right=Right}) ->
    #node{val=-Val, left=invert(Right), right=invert(Left)}.

sumNodes(undefined) -> 0;
sumNodes(#node{val=Val, left=Left, right=Right}) ->
    Val + sumNodes(Left) + sumNodes(Right).