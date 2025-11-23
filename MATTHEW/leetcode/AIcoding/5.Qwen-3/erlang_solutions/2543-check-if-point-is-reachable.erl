-module(reachable).
-export([is_reachable/2]).

is_reachable(X, Y) ->
    is_reachable(X, Y, 0, 0).

is_reachable(X, Y, X, Y) ->
    true;
is_reachable(X, Y, CurX, CurY) when CurX > X; CurY > Y ->
    false;
is_reachable(X, Y, CurX, CurY) ->
    case {CurX + CurY, CurX * CurY} of
        {Sum, Product} when Sum =< X + Y, Product =< X * Y ->
            is_reachable(X, Y, CurX + 1, CurY) orelse
            is_reachable(X, Y, CurX, CurY + 1);
        _ ->
            false
    end.