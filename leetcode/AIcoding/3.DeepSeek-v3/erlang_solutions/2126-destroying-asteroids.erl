-spec asteroids_destroyed(Mass :: integer(), Asteroids :: [integer()]) -> boolean().
asteroids_destroyed(Mass, Asteroids) ->
    Sorted = lists:sort(Asteroids),
    check_asteroids(Mass, Sorted).

check_asteroids(Mass, []) ->
    true;
check_asteroids(Mass, [A | Asteroids]) ->
    case Mass >= A of
        true -> check_asteroids(Mass + A, Asteroids);
        false -> false
    end.