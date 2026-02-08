-module(jump_game).
-export([can_jump/1]).

can_jump(Nums) ->
    can_jump(Nums, 0, length(Nums) - 1).

can_jump(_, Pos, Target) when Pos >= Target -> true;
can_jump(Nums, Pos, Target) ->
    MaxJump = lists:nth(Pos + 1, Nums),
    lists:any(fun(Jump) -> can_jump(Nums, Pos + Jump, Target) end, lists:seq(1, MaxJump)).