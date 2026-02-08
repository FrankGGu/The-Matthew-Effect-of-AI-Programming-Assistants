-module(solution).
-export([find_closest_person/2]).

find_closest_person(People, Target) ->
    lists:foldl(fun(X, {Closest, MinDist}) ->
        Dist = abs(X - Target),
        case Dist < MinDist of
            true -> {X, Dist};
            false -> {Closest, MinDist}
        end
    end, {undefined, infinity}, People).