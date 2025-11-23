-module(longest_harmonious_subsequence).
-export([findLHS/1]).

findLHS(Nums) ->
    findLHS(Nums, maps:new()).

findLHS([], Acc) ->
    findLHS_helper(maps:to_list(Acc), 0);
findLHS([H|T], Acc) ->
    Count = maps:get(H, Acc, 0) + 1,
    findLHS(T, maps:put(H, Count, Acc)).

findLHS_helper([], Max) ->
    Max;
findLHS_helper([{Key, Value}|T], Max) ->
    case lists:keyfind(Key + 1, 1, T) of
        false ->
            findLHS_helper(T, Max);
        {_, NextValue} ->
            NewMax = max(Max, Value + NextValue),
            findLHS_helper(T, NewMax)
    end.