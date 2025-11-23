-module(solution).
-export([asteroidCollision/1]).

asteroidCollision(Asteroids) ->
    asteroidCollision(Asteroids, []).

asteroidCollision([], Result) ->
    lists:reverse(Result);
asteroidCollision([H | T], Result) ->
    NewResult = handleCollision(H, Result),
    asteroidCollision(T, NewResult).

handleCollision(Asteroid, Result) ->
    case Result of
        [] -> [Asteroid];
        [Last | _] when Last > 0 -> [Asteroid | Result]; % Move right
        [Last | _] when Last < 0 ->
            case Asteroid < 0 of
                true -> [Asteroid | Result]; % Both move left
                false -> handleRightCollision(Asteroid, Last, Result) % Right vs Left
            end
    end.

handleRightCollision(Asteroid, Last, Result) ->
    case Asteroid + Last of
        0 -> Result; % They destroy each other
        _ when Asteroid + Last < 0 -> [Asteroid | Result]; % Right destroyed
        _ -> Result % Left destroyed
    end.