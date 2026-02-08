-module(distribute_coins).
-export([distribute_coins/1]).

distribute_coins(Root) ->
    {_, Moves} = dfs(Root),
    Moves.

dfs(null) ->
    {0, 0};
dfs(Node) ->
    {LNeed, LMoves} = dfs(Node#node.left),
    {RNeed, RMoves} = dfs(Node#node.right),
    Need = LNeed + RNeed + Node#node.val - 1,
    Moves = abs(Need) + LMoves + RMoves,
    {Need, Moves}.

-record(node, {val, left, right}).