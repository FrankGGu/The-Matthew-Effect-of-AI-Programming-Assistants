-module(solution).
-export([count_similar_pairs/1]).

count_similar_pairs(Strings) ->
    CountMap = lists:foldl(fun(S, Acc) -> 
        Key = lists:sort(lists:usort(string:to_list(S))),
        maps:update_with(Key, fun(Count) -> Count + 1 end, 1, Acc)
    end, #{}, Strings),
    maps:fold(fun(_Key, Count, Acc) ->
        Acc + (Count * (Count - 1)) div 2
    end, 0, CountMap).