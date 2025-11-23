-module(solution).
-export([destroy_asteroids/2]).

destroy_asteroids(Asteroids, Power) ->
    destroy_asteroids_helper(Asteroids, Power, []).

destroy_asteroids_helper([], _, _) -> true;
destroy_asteroids_helper([H | T], Power, Stack) when H > 0 -> 
    destroy_asteroids_helper(T, Power, [H | Stack]);
destroy_asteroids_helper([H | T], Power, [Top | Rest]) when H < 0 ->
    NewPower = Top + H,
    case NewPower of
        _ when NewPower > 0 -> 
            destroy_asteroids_helper(T, NewPower, Rest);
        _ -> 
            false
    end.