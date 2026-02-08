-module(minimum_positive_sum_subarray).
-export([min_positive_sum/1]).

min_positive_sum(Nums) ->
    min_positive_sum(Nums, 0, 0, 1000000).

min_positive_sum([], _, _, Min) ->
    Min;
min_positive_sum([H | T], CurrentSum, Start, Min) ->
    NewCurrent = CurrentSum + H,
    if
        NewCurrent > 0 ->
            NewMin = if NewCurrent < Min -> NewCurrent; true -> Min end,
            min_positive_sum(T, NewCurrent, Start + 1, NewMin);
        true ->
            min_positive_sum(T, 0, 0, Min)
    end.