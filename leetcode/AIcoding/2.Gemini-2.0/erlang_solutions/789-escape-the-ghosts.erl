-module(escape_the_ghosts).
-export([escape_the_ghosts/2]).

escape_the_ghosts(Ghosts, Target) ->
  escape_the_ghosts(Ghosts, Target, 0, 0).

escape_the_ghosts([], _Target, X, Y) ->
  true;
escape_the_ghosts([H|T], [Tx, Ty], X, Y) ->
  [Gx, Gy] = H,
  PlayerDistance = abs(Tx - X) + abs(Ty - Y),
  GhostDistance = abs(Tx - Gx) + abs(Ty - Gy),
  if
    GhostDistance <= PlayerDistance ->
      false;
    true ->
      escape_the_ghosts(T, [Tx, Ty], X, Y)
  end.