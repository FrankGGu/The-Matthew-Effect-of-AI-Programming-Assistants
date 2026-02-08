-module(solution).
-export([maxDepth/1]).

type(node()) :: {none} | {node(), node()}.

maxDepth(nil) -> 0;
maxDepth({Left, Right}) -> 1 + max(maxDepth(Left), maxDepth(Right)).