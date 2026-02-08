-module(solution).
-export([jump/1]).

jump(Jumps) ->
    jump_helper(Jumps, 0, 0).

jump_helper([], Steps, _) -> Steps;
jump_helper(Jumps, Steps, Position) ->
    MaxReach = lists:max(lists:map(fun(X) -> Position + X end, tl(Jumps))),
    case MaxReach of
        Position -> Steps; % If we can't move further
        _ -> jump_helper(tl(Jumps), Steps + 1, MaxReach)
    end.