-module(solution).
-export([successfulPairs/3]).

successfulPairs(Spells, Potions, Success) ->
    SortedPotions = lists:sort(Potions),
    PotionsArray = array:from_list(SortedPotions),
    NumPotions = array:size(PotionsArray),
    lists:map(fun(Spell) ->
        MinPotionRequired = (Success + Spell - 1) div Spell,

        FirstSuccessfulIdx = binary_search_array_first_ge(MinPotionRequired, PotionsArray, 0, NumPotions - 1),

        case FirstSuccessfulIdx of
            -1 -> 0;
            Idx -> NumPotions - Idx
        end
    end, Spells).

binary_search_array_first_ge(Target, Arr, Low, High) ->
    if
        Low > High ->
            -1;
        true ->
            Mid = Low + (High - Low) div 2,
            Element = array:get(Mid, Arr),
            if
                Element >= Target ->
                    LeftResult = binary_search_array_first_ge(Target, Arr, Low, Mid - 1),
                    case LeftResult of
                        -1 -> Mid;
                        _ -> LeftResult
                    end;
                true ->
                    binary_search_array_first_ge(Target, Arr, Mid + 1, High)
            end
    end.