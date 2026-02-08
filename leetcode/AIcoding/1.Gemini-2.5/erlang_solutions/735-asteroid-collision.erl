-module(solution).
-export([asteroid_collision/1]).

asteroid_collision(Asteroids) ->
    lists:reverse(solve(Asteroids, [])).

solve([], Stack) ->
    Stack;
solve([Asteroid | Rest], Stack) ->
    handle_asteroid(Asteroid, Stack, Rest).

handle_asteroid(Asteroid, [], RemainingAsteroids) ->
    % Stack is empty, just add the asteroid
    solve(RemainingAsteroids, [Asteroid]);
handle_asteroid(Asteroid, [Top | StackRest], RemainingAsteroids) when Asteroid > 0 ->
    % Incoming asteroid moves right. It will never collide with anything already on the stack
    % (either it's behind a right-mover or moving away from a left-mover).
    % So, it's simply added to the stack.
    solve(RemainingAsteroids, [Asteroid | [Top | StackRest]]);
handle_asteroid(Asteroid, [Top | StackRest], RemainingAsteroids) when Top < 0 ->
    % Incoming asteroid moves left, top of stack moves left. No collision.
    % Asteroid is simply added to the stack.
    solve(RemainingAsteroids, [Asteroid | [Top | StackRest]]);
handle_asteroid(Asteroid, [Top | StackRest], RemainingAsteroids) when Asteroid < 0, Top > 0 ->
    % Collision scenario: Incoming asteroid moves left, top of stack moves right.
    AbsAsteroid = abs(Asteroid),
    if
        AbsAsteroid == Top ->
            % Both asteroids have the same size, both explode.
            % Pop the top from the stack, and the incoming asteroid is destroyed.
            solve(RemainingAsteroids, StackRest);
        AbsAsteroid > Top ->
            % Incoming asteroid is larger, top of stack explodes.
            % Pop the top from the stack, and the incoming asteroid continues to collide
            % with the new top of the stack (if any).
            handle_asteroid(Asteroid, StackRest, RemainingAsteroids);
        AbsAsteroid < Top ->
            % Top of stack is larger, incoming asteroid explodes.
            % Top remains on the stack, and the incoming asteroid is destroyed.
            solve(RemainingAsteroids, [Top | StackRest])
    end.