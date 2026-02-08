-module(minimum_elements_to_add).
-export([min_additions/2]).

min_additions(Nums, Target) ->
    min_additions(Nums, Target, 0, 0).

min_additions([], _Target, _Sum, Count) ->
    Count;
min_additions([H | T], Target, Sum, Count) ->
    NewSum = Sum + H,
    if
        NewSum < Target ->
            min_additions(T, Target, NewSum, Count);
        NewSum == Target ->
            min_additions(T, Target, 0, Count + 1);
        true ->
            min_additions(T, Target, H, Count + 1)
    end.