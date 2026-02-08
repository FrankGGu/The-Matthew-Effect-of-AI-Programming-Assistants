-module(k_diff_pairs).
-export([find_k_diff_pairs/1]).

find_k_diff_pairs(Nums) ->
    Count = lists:foldl(fun(N, Acc) -> maps:update_with(N, fun(V) -> V + 1 end, 1, Acc) end, maps:new(), Nums),
    find_k_diff_pairs(Count, maps:keys(Count), 0).

find_k_diff_pairs(_, [], Acc) ->
    Acc;
find_k_diff_pairs(Count, [N | Rest], Acc) ->
    case maps:is_key(N + 1, Count) of
        true ->
            find_k_diff_pairs(Count, Rest, Acc + 1);
        false ->
            find_k_diff_pairs(Count, Rest, Acc)
    end.