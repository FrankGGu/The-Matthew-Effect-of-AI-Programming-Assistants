-module(solution).
-export([asteroidCollision/1]).

asteroidCollision(Asteroids) ->
    asteroidCollision(Asteroids, []).

asteroidCollision([], Result) ->
    lists:reverse(Result);
asteroidCollision([H | T], Result) ->
    asteroidCollision(T, handleAsteroid(H, Result)).

handleAsteroid(Asteroid, Result) ->
    case Result of
        [] -> [Asteroid];
        [Last | _] when Last > 0 -> [Asteroid | Result];  % Right-moving asteroid
        [Last | Rest] when Last < 0 ->
            case Asteroid > 0 of
                true -> [Asteroid | Result];  % Right-moving asteroid collides with left-moving asteroid
                false -> handleCollision(Asteroid, Last, Rest)
            end
    end.

handleCollision(Asteroid, Last, Rest) ->
    case Last < 0 of
        true -> [Asteroid, Last | Rest];  % Both asteroids moving left, no collision
        false -> 
            case Asteroid + Last of
                0 -> Rest;  % Both asteroids destroy each other
                Result when Result > 0 -> [Result | Rest];  % Right-moving asteroid survives
                _ -> [Last | handleCollision(Asteroid, hd(Rest), tl(Rest))]  % Left-moving asteroid survives
            end
    end.