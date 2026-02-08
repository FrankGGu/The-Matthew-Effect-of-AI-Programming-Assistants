-module(solution).
-export([minimum_jumps/3]).

minimum_jumps(Start, End, Jump) when Start =< End ->
    minimum_jumps(Start, End, Jump, 0, 0).

minimum_jumps(Current, End, Jump, Steps, LastJump) when Current >= End ->
    Steps;
minimum_jumps(Current, End, Jump, Steps, LastJump) ->
    NextJump = min(Jump, LastJump + 1),
    JumpForward = Current + NextJump,
    JumpBackward = Current - NextJump,
    case JumpBackward < 0 of
        true ->
            minimum_jumps(JumpForward, End, Jump, Steps + 1, NextJump);
        false ->
            min(minimum_jumps(JumpForward, End, Jump, Steps + 1, NextJump),
                minimum_jumps(JumpBackward, End, Jump, Steps + 1, NextJump))
    end.