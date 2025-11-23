-module(max_diff_even_odd).
-export([maxDiffEvenOdd/1]).

maxDiffEvenOdd(Nums) ->
    Count = count_freq(Nums),
    lists:foldl(fun({Key, Val}, Acc) ->
        case Val rem 2 of
            0 -> Max = max(Acc, Key * Val), Max;
            _ -> Acc
        end
    end, -1, Count).

count_freq(Nums) ->
    count_freq(Nums, dict:new()).

count_freq([], Dict) ->
    dict:to_list(Dict);
count_freq([H | T], Dict) ->
    NewDict = dict:update(H, fun(V) -> V + 1 end, 1, Dict),
    count_freq(T, NewDict).