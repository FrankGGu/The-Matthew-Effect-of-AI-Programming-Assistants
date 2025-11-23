-module(water_and_jug_problem).
-export([can_measure/2]).

can_measure(Jug1, Jug2) ->
    can_measure(Jug1, Jug2, 0, 0).

can_measure(Jug1, Jug2, X, Y) ->
    case {X, Y} of
        {Target, _} when Target == 4 -> true;
        {_, Target} when Target == 4 -> true;
        _ -> 
            Set = sets:from_list([X, Y]),
            case sets:size(Set) == 2 of
                true -> false;
                false ->
                    NewStates = [
                        {Jug1, Y},
                        {X, Jug2},
                        {0, Y},
                        {X, 0},
                        {X + Y, 0} when X + Y =< Jug1,
                        {0, X + Y} when X + Y =< Jug2,
                        {X - Y, 0} when X >= Y,
                        {0, Y - X} when Y >= X
                    ],
                    lists:any(fun(State) -> can_measure(Jug1, Jug2, element(1, State), element(2, State)) end, NewStates)
            end
    end.