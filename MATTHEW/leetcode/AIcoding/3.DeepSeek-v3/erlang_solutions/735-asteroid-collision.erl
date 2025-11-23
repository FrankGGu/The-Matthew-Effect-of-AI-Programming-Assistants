-spec asteroid_collision(Asteroids :: [integer()]) -> [integer()].
asteroid_collision(Asteroids) ->
    lists:reverse(asteroid_collision(Asteroids, [])).

asteroid_collision([], Stack) -> Stack;
asteroid_collision([A | As], []) ->
    asteroid_collision(As, [A]);
asteroid_collision([A | As], [B | Bs] = Stack) ->
    if
        B > 0, A < 0 ->
            if
                abs(B) > abs(A) ->
                    asteroid_collision(As, Stack);
                abs(B) < abs(A) ->
                    asteroid_collision([A | As], Bs);
                true ->
                    asteroid_collision(As, Bs)
            end;
        true ->
            asteroid_collision(As, [A | Stack])
    end.