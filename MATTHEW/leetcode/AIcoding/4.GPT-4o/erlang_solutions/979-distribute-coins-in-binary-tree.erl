-module(solution).
-export([distribute_coins/1]).

-record(node, {val, left = null, right = null}).

distribute_coins(Root) ->
    {Moves, _} = distribute(Root),
    Moves.

distribute(null) ->
    {0, 0};
distribute(#node{val = Val, left = Left, right = Right}) ->
    {LeftMoves, LeftExcess} = distribute(Left),
    {RightMoves, RightExcess} = distribute(Right),
    Moves = LeftMoves + RightMoves + abs(LeftExcess) + abs(RightExcess),
    {Moves, Val + LeftExcess + RightExcess - 1}.