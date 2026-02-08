-module(solution).
-export([jump/1]).

jump(Nums) ->
    Len = length(Nums),
    if
        Len =< 1 -> 0;
        true ->
            jump_recursive(Nums, Len, 0, 0, 0, 0)
    end.

jump_recursive([JumpVal | Rest], Len, CurrentIndex, CurrentEnd, FarthestReach, Jumps) when CurrentIndex < Len - 1 ->
    NewFarthestReach = max(FarthestReach, CurrentIndex + JumpVal),

    if
        CurrentIndex == CurrentEnd ->
            jump_recursive(Rest, Len, CurrentIndex + 1, NewFarthestReach, NewFarthestReach, Jumps + 1);
        true ->
            jump_recursive(Rest, Len, CurrentIndex + 1, CurrentEnd, NewFarthestReach, Jumps)
    end;
jump_recursive(_Rest, _Len, _CurrentIndex, _CurrentEnd, _FarthestReach, Jumps) ->
    Jumps.