-module(solution).
-export([asteroid_collision/1]).

asteroid_collision(Asteroids) ->
    process_asteroids(Asteroids, []).

process_asteroids([], Stack) ->
    lists:reverse(Stack);
process_asteroids([CurrentAsteroid | RemainingAsteroids], Stack) ->
    NewStack = resolve_collision(CurrentAsteroid, Stack),
    process_asteroids(RemainingAsteroids, NewStack).

resolve_collision(Asteroid, []) ->
    [Asteroid];
resolve_collision(Asteroid, Stack = [TopAsteroid | RestStack]) when Asteroid > 0 ->
    [Asteroid | Stack];
resolve_collision(Asteroid, Stack = [TopAsteroid | RestStack]) when TopAsteroid < 0 ->
    [Asteroid | Stack];
resolve_collision(Asteroid, Stack = [TopAsteroid | RestStack]) when Asteroid < 0 and TopAsteroid > 0 ->
    AbsCurrent = abs(Asteroid),
    case AbsCurrent of
        _ when AbsCurrent > TopAsteroid ->
            resolve_collision(Asteroid, RestStack);
        _ when AbsCurrent < TopAsteroid ->
            Stack;
        _ when AbsCurrent == TopAsteroid ->
            RestStack
    end.