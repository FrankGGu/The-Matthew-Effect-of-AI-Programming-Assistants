-module(electric_car).
-export([can_complete_circuit/2]).

can_complete_circuit(Gas, Cost) ->
    can_complete_circuit(Gas, Cost, 0, 0, 0).

can_complete_circuit(Gas, Cost, Start, CurrentGas, Stations) ->
    case Stations of
        length(Gas) ->
            Start;
        _ ->
            case CurrentGas + lists:nth(Stations + 1, Gas) - lists:nth(Stations + 1, Cost) >= 0 of
                true ->
                    can_complete_circuit(Gas, Cost, Start, CurrentGas + lists:nth(Stations + 1, Gas) - lists:nth(Stations + 1, Cost), Stations + 1);
                false ->
                    can_complete_circuit(Gas, Cost, Stations + 1, 0, Stations + 1)
            end
    end.