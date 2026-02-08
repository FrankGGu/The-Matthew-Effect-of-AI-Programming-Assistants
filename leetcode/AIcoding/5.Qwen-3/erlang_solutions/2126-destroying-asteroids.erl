-module(destroying_asteroids).
-export([destroy_all/1]).

destroy_all(Asteroids) ->
    destroy_all(Asteroids, 1).

destroy_all([], _) ->
    true;
destroy_all([A | T], ShipSize) when A =< ShipSize ->
    destroy_all(T, ShipSize + A);
destroy_all([A | _], _) when A > ShipSize ->
    false.