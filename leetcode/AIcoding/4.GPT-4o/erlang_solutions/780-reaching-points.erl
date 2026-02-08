-module(solution).

-export([can_reach/4]).

can_reach(X, Y, TargetX, TargetY) ->
    case {X, Y, TargetX, TargetY} of
        {_, _, TargetX, TargetY} -> true;
        {X, Y, TargetX, TargetY} when X > TargetX orelse Y > TargetY -> false;
        _ -> can_reach(X + Y, Y, TargetX, TargetY) orelse can_reach(X, X + Y, TargetX, TargetY)
    end.