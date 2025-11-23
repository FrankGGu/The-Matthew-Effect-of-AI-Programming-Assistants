-module(solution).
-export([canJump/1]).

canJump(Nums) ->
    LastIndex = length(Nums) - 1,
    can_jump_recursive(Nums, 0, 0, LastIndex).

can_jump_recursive([], _CurrentIndex, MaxReach, LastIndex) ->
    MaxReach >= LastIndex;
can_jump_recursive([_H|_T], CurrentIndex, MaxReach, _LastIndex) when CurrentIndex > MaxReach ->
    false;
can_jump_recursive([JumpVal|Rest], CurrentIndex, MaxReach, LastIndex) ->
    NewMaxReach = max(MaxReach, CurrentIndex + JumpVal),
    if
        NewMaxReach >= LastIndex ->
            true;
        true ->
            can_jump_recursive(Rest, CurrentIndex + 1, NewMaxReach, LastIndex)
    end.