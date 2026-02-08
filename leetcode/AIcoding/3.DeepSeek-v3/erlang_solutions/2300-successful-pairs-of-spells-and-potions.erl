-module(solution).
-export([successful_pairs/3]).

successful_pairs(Spells, Potions, Success) ->
    SortedPotions = lists:sort(Potions),
    lists:map(fun(Spell) -> count_pairs(Spell, SortedPotions, Success) end, Spells).

count_pairs(Spell, SortedPotions, Success) ->
    N = length(SortedPotions),
    Left = 0,
    Right = N - 1,
    Threshold = (Success + Spell - 1) div Spell,
    binary_search(SortedPotions, Threshold, Left, Right, N).

binary_search(_, _, Left, Right, N) when Left > Right ->
    N - Left;
binary_search(SortedPotions, Threshold, Left, Right, N) ->
    Mid = (Left + Right) div 2,
    case lists:nth(Mid + 1, SortedPotions) of
        Val when Val >= Threshold ->
            binary_search(SortedPotions, Threshold, Left, Mid - 1, N);
        _ ->
            binary_search(SortedPotions, Threshold, Mid + 1, Right, N)
    end.