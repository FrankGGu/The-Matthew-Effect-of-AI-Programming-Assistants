-module(solutions).
-export([successful_pairs/2]).

successful_pairs(Spells, Potions) ->
    SortedPotions = lists:sort(Potions),
    N = length(SortedPotions),
    [find_min_index(S, SortedPotions, N) || S <- Spells].

find_min_index(Spell, P, N) ->
    find_min_index(Spell, P, 0, N - 1, N).

find_min_index(_, _, Left, Right, _) when Left > Right ->
    N;
find_min_index(Spell, P, Left, Right, N) ->
    Mid = (Left + Right) div 2,
    Case = case lists:nth(Mid + 1, P) of
               Val when Val * Spell >= 1000000000 ->
                   find_min_index(Spell, P, Left, Mid - 1, N);
               _ ->
                   find_min_index(Spell, P, Mid + 1, Right, N)
           end,
    Case.