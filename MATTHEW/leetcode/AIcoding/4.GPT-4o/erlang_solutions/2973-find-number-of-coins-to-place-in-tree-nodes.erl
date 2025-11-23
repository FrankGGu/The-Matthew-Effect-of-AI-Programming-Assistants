-module(solution).
-export([distribute_coins/1]).

-record(node, {val, left, right}).

distribute_coins(Tree) ->
    {Coins, Moves} = count_coins(Tree),
    Moves.

count_coins(nil) -> {0, 0};
count_coins(#node{val=Val, left=Left, right=Right}) ->
    {LeftCoins, LeftMoves} = count_coins(Left),
    {RightCoins, RightMoves} = count_coins(Right),
    TotalCoins = Val + LeftCoins + RightCoins - 1,
    TotalMoves = LeftMoves + RightMoves + abs(LeftCoins + RightCoins + Val - 1),
    {TotalCoins, TotalMoves}.