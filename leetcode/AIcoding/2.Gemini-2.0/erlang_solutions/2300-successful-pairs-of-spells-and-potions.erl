-module(successful_pairs).
-export([successful_pairs/3]).

successful_pairs(Spells, Potions, Success) ->
    SortedPotions = lists:sort(Potions),
    [count_successful(Spell, SortedPotions, Success) || Spell <- Spells].

count_successful(Spell, SortedPotions, Success) ->
    count_successful(Spell, SortedPotions, Success, 0).

count_successful(Spell, SortedPotions, Success, Acc) ->
    case SortedPotions of
        [] ->
            Acc;
        [Potion | Rest] ->
            case Spell * Potion >= Success of
                true ->
                    length(SortedPotions) - Acc;
                false ->
                    count_successful(Spell, Rest, Success, Acc + 1)
            end
    end.