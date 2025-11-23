-module(special_subarrays).
-export([sumCounts/1]).

sumCounts(Nums) ->
    sumCounts(Nums, 0, 0, 0, dict:new()).

sumCounts([], Acc, _, _, _) ->
    Acc;

sumCounts([H | T], Acc, Left, Count, Dict) ->
    case dict:is_key(H, Dict) of
        true ->
            Prev = dict:fetch(H, Dict),
            NewDict = dict:store(H, Left + 1, dict:erase(H, Dict)),
            sumCounts(T, Acc + (Count * Count), Left + 1, Count - (Prev - Left), NewDict);
        false ->
            NewDict = dict:store(H, Left + 1, Dict),
            sumCounts(T, Acc + (Count * Count), Left + 1, Count + 1, NewDict)
    end.