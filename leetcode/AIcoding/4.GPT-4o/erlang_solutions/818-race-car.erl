-module(race_car).
-export([race_car/1]).

race_car(Target) ->
    MinSteps = fun(N, Pos, Speed) ->
        case Pos of
            Target -> N;
            _ when Pos > Target -> MinSteps(N + 1, Pos - Speed, -Speed);
            _ -> min(MinSteps(N + 1, Pos + Speed, Speed * 2), MinSteps(N + 1, Pos, -Speed))
        end
    end,

    MinSteps(0, 0, 1).