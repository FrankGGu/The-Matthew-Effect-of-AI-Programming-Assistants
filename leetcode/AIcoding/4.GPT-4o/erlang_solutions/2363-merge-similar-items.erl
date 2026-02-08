-module(solution).
-export([merge_similar_items/2]).

merge_similar_items(List1, List2) ->
    Merged = lists:foldl(fun({Key, Value}, Acc) ->
        case lists:keyfind(Key, 1, Acc) of
            false -> [{Key, Value} | Acc];
            {Key, OldValue} -> [{Key, OldValue + Value} | lists:keydelete(Key, 1, Acc)]
        end
    end, List1, List2),
    lists:sort(fun({K1, _}, {K2, _}) -> K1 < K2 end, Merged).