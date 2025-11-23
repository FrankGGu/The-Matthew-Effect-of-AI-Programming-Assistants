-module(solution).
-export([jump/1]).

jump(Nums) ->
    Len = length(Nums),
    if
        Len =< 1 -> 0;
        true ->
            NumsTuple = list_to_tuple(Nums),
            jump_helper(0, 0, 0, 0, NumsTuple, Len)
    end.

jump_helper(Index, Jumps, CurrentReach, NextReach, NumsTuple, Len) ->
    Val = element(Index + 1, NumsTuple),
    NewNextReach = max(NextReach, Index + Val),

    if Index == CurrentReach ->
        NewJumps = Jumps + 1,
        NewCurrentReach = NewNextReach,
        if NewCurrentReach >= Len - 1 ->
            NewJumps;
        else
            jump_helper(Index + 1, NewJumps, NewCurrentReach, NewNextReach, NumsTuple, Len)
        end;
    true ->
        jump_helper(Index + 1, Jumps, CurrentReach, NewNextReach, NumsTuple, Len)
    end.