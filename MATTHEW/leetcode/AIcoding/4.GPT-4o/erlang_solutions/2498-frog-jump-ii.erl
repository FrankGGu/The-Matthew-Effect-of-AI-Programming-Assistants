-module(frog_jump).
-export([frog_jump/1]).

frog_jump(Jumps) ->
    case jumps(Jumps, 0, 0) of
        {ok, Res} -> Res;
        _ -> 0
    end.

jumps([], _Pos, _Steps) -> {ok, 0};
jumps([H | T], Pos, Steps) ->
    NextPos = Pos + H,
    {ok, NextSteps} = jumps(T, NextPos, Steps + 1),
    {ok, min(Steps + 1, NextSteps)}.

min(X, Y) when X < Y -> X;
min(_, Y) -> Y.