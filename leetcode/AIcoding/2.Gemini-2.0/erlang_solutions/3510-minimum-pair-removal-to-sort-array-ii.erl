-module(minimum_pair_removal_to_sort_array_ii).
-export([min_removal/1]).

min_removal(Nums) ->
    min_removal(Nums, []).

min_removal([], Stack) ->
    length(Stack).

min_removal([H|T], Stack) ->
    case Stack of
        [] ->
            min_removal(T, [H]);
        [Top|Rest] ->
            if H >= Top then
                min_removal(T, [H|Stack])
            else
                min_removal(T, [H|Rest])
            end
    end.