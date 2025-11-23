-module(minimum_initial_energy).
-export([min_initial_energy/1]).

min_initial_energy(Tasks) ->
    Sorted = lists:sort(fun({E1, R1}, {E2, R2}) -> E1 + R1 < E2 + R2 end, Tasks),
    Energy = 0,
    lists:foldl(fun({EnergyRequired, Reward}, Acc) ->
        if
            Acc >= EnergyRequired -> Acc - EnergyRequired + Reward;
            true -> EnergyRequired - Acc + Reward
        end
    end, Energy, Sorted).