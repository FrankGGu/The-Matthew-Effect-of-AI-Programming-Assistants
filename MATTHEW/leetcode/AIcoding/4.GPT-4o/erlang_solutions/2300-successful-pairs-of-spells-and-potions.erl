-module(solution).
-export([successful_pairs/2]).

successful_pairs(Spells, Potions) ->
    SortedPotions = lists:sort(Potions),
    lists:map(fun(Spell) -> count_successful_pairs(Spell, SortedPotions) end, Spells).

count_successful_pairs(Spell, Potions) ->
    N = length(Potions),
    count_pairs(Spell, Potions, 0, N).

count_pairs(_, [], Count, _) -> Count;
count_pairs(Spell, [Potion | Rest], Count, N) ->
    if
        Spell * Potion >= 1000 -> count_pairs(Spell, Rest, N - length(Rest), N);
        true -> count_pairs(Spell, Rest, Count, N)
    end.