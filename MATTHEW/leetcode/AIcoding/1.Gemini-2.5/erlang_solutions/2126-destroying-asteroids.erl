-module(solution).
-export([asteroids_destroyed/2]).

-spec asteroids_destroyed(Mass :: integer(), Asteroids :: [integer()]) -> boolean().
asteroids_destroyed(Mass, Asteroids) ->
    SortedAsteroids = lists:sort(Asteroids),
    check_destroy(Mass, SortedAsteroids).

check_destroy(CurrentMass, []) ->
    true;
check_destroy(CurrentMass, [H|T]) ->
    if
        CurrentMass >= H ->
            check_destroy(CurrentMass + H, T);
        true ->
            false
    end.