-module(minimum_damage).
-export([minimum_damage/2]).

minimum_damage(Attackers, BobHealth) ->
    Sorted = lists:sort(fun({_, A}, {_, B}) -> A > B end, Attackers),
    TotalDamage = 0,
    process_attackers(Sorted, BobHealth, TotalDamage).

process_attackers([], _, TotalDamage) ->
    TotalDamage;
process_attackers([{Name, Power} | Rest], BobHealth, TotalDamage) ->
    Damage = min(Power, BobHealth),
    NewTotal = TotalDamage + Damage,
    NewBobHealth = BobHealth - Damage,
    process_attackers(Rest, NewBobHealth, NewTotal).