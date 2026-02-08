-module(solution).
-export([maximum_total_damage/2]).

maximum_total_damage(damage, spell) ->
    maximum_total_damage(damage, spell, 0).

maximum_total_damage(Damage, Spell, Acc) ->
    SortedDamage = lists:sort(Damage),
    SortedSpell = lists:sort(Spell),

    maximum_total_damage_helper(SortedDamage, SortedSpell, Acc).

maximum_total_damage_helper([], _, Acc) ->
    Acc;
maximum_total_damage_helper(_, [], Acc) ->
    Acc;
maximum_total_damage_helper(Damage, Spell, Acc) ->
    {D, RestDamage} = lists:split(length(Damage) - 1, Damage),
    LastDamage = lists:last(Damage),
    {S, RestSpell} = lists:split(length(Spell) - 1, Spell),
    LastSpell = lists:last(Spell),

    NewAcc1 = Acc + LastDamage * LastSpell,

    case RestDamage of
        [] ->
            maximum_total_damage_helper(Damage, lists:sublist(Spell,1, length(Spell) -1 ), Acc);
        _ ->
            case RestSpell of
                [] ->
                    maximum_total_damage_helper(lists:sublist(Damage, 1, length(Damage) -1), Spell, Acc);
                _ ->
                    NewDamage = lists:sublist(Damage, 1, length(Damage) - 1),
                    NewSpell = lists:sublist(Spell, 1, length(Spell) -1),
                    V1 = maximum_total_damage_helper(NewDamage, Spell, Acc),
                    V2 = maximum_total_damage_helper(Damage, NewSpell, Acc),
                    V3 = maximum_total_damage_helper(NewDamage, NewSpell, NewAcc1),
                    V4 = maximum_total_damage_helper(lists:sublist(Damage,1, length(Damage) -1), lists:sublist(Spell,1, length(Spell) -1 ), Acc + LastDamage * LastSpell),

                    lists:max([V1, V2, V3, V4])
            end
    end.