-module(solution).
-export([max_jumps/1]).

max_jumps(Jumps) ->
    Length = length(Jumps),
    max_jumps_helper(Jumps, Length, 0, 0).

max_jumps_helper(_, Length, Position, Count) when Position >= Length - 1 -> 
    Count;
max_jumps_helper(Jumps, Length, Position, Count) -> 
    MaxJump = lists:nth(Position + 1, Jumps),
    NextPosition = lists:seq(Position + 1, min(Position + MaxJump, Length - 1)),
    lists:max(lists:map(fun(Pos) -> max_jumps_helper(Jumps, Length, Pos, Count + 1) end, NextPosition)).