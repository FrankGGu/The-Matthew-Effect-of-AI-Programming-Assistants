-module(max_total_damage_with_spell_casting).
-export([maximum_total_damage/1]).

maximum_total_damage(Spells) ->
    Sorted = lists:sort(Spells),
    DamageMap = maps:new(),
    MaxDamage = 0,
    process_spells(Sorted, DamageMap, MaxDamage).

process_spells([], _DamageMap, MaxDamage) ->
    MaxDamage;
process_spells([Spell | Rest], DamageMap, MaxDamage) ->
    CurrentDamage = maps:get(Spell, DamageMap, 0),
    NewMaxDamage = max(MaxDamage, CurrentDamage),
    UpdatedMap = maps:put(Spell, CurrentDamage + 1, DamageMap),
    process_spells(Rest, UpdatedMap, NewMaxDamage).