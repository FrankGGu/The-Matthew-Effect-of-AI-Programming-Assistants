-module(solution).
-export([minimum_damage/2]).

minimum_damage(health, damage) ->
    min_damage(health, damage, 0).

min_damage(0, _, Acc) -> 
    Acc;
min_damage(Health, Damage, Acc) ->
    NewHealth = Health - Damage,
    NewAcc = Acc + Damage,
    min_damage(max(NewHealth, 0), Damage, NewAcc).