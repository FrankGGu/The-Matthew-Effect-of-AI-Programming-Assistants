-module(solution).
-export([min_initial_energy/1]).

min_initial_energy(Tasks) ->
    lists:foldl(fun({a, b}, {Energy, Required}) ->
        {Energy - b + a, max(Required, Energy - b + a)}
    end, {0, 0}, Tasks)
    |> (fun {FinalEnergy, Required} -> max(1, Required + 1) end).