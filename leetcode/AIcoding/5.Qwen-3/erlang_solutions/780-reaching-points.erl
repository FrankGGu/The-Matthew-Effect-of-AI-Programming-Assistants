-module(reaching_points).
-export([is_reachable/3]).

is_reachable(X, Y, target) ->
    is_reachable(X, Y, target, 1).

is_reachable(X, Y, Target, _Step) when X > Target orelse Y > Target ->
    false;
is_reachable(X, Y, Target, _Step) when X == Target andalso Y == Target ->
    true;
is_reachable(X, Y, Target, _Step) when X == Target ->
    Y rem X == Target rem X;
is_reachable(X, Y, Target, _Step) when Y == Target ->
    X rem Y == Target rem Y;
is_reachable(X, Y, Target, _Step) ->
    if
        X < Y ->
            is_reachable(X, Y rem X, Target, _Step + 1);
        true ->
            is_reachable(Y rem X, X, Target, _Step + 1)
    end.