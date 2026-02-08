-module(frog_jump_ii).
-export([can_reach/2]).

can_reange(Jumps, MaxJump) ->
    can_reach(Jumps, MaxJump, 0, 0).

can_reach([], _, _, _) ->
    true;
can_reach([H | T], MaxJump, Pos, Steps) ->
    if
        H > Pos + MaxJump ->
            false;
        true ->
            NewPos = H,
            NewSteps = Steps + 1,
            can_reach(T, MaxJump, NewPos, NewSteps)
    end.