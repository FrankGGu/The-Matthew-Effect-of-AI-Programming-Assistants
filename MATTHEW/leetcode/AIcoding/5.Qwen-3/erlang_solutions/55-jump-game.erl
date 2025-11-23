-module(jump_game).
-export([can_jump/1]).

can_jump(Nums) ->
    can_jump(Nums, 0, 0).

can_jump(_, Index, MaxReach) when Index >= length(Nums) ->
    true;
can_jump(Nums, Index, MaxReach) when Index > MaxReach ->
    false;
can_jump(Nums, Index, MaxReach) ->
    NewMaxReach = max(MaxReach, Index + lists:nth(Index + 1, Nums)),
    can_jump(Nums, Index + 1, NewMaxReach).