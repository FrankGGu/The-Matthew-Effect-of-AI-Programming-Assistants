-spec asteroid_collision(Asteroids :: [integer()]) -> [integer()].
asteroid_collision(Asteroids) ->
    asteroid_collision(Asteroids, []).

asteroid_collision([], Stack) ->
    lists:reverse(Stack);
asteroid_collision([A | As], []) ->
    asteroid_collision(As, [A]);
asteroid_collision([A | As], [B | Bs] = Stack) ->
    if
        B > 0, A < 0 ->
            case abs(B) =:= abs(A) of
                true -> asteroid_collision(As, Bs);
                false ->
                    case abs(B) > abs(A) of
                        true -> asteroid_collision(As, Stack);
                        false -> asteroid_collision([A | As], Bs)
                    end
            end;
        true -> asteroid_collision(As, [A | Stack])
    end.