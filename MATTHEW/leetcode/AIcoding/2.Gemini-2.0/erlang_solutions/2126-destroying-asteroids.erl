-module(destroying_asteroids).
-export([destroyAsteroids/2]).

destroyAsteroids(Mass, Asteroids) ->
    SortedAsteroids = lists:sort(Asteroids),
    destroyAsteroidsHelper(Mass, SortedAsteroids).

destroyAsteroidsHelper(Mass, []) ->
    true;
destroyAsteroidsHelper(Mass, [H|T]) ->
    if
        Mass >= H ->
            destroyAsteroidsHelper(Mass + H, T);
        true ->
            false
    end.