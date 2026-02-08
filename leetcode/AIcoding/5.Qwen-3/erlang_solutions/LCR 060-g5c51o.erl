-module(top_k_frequent).
-export([topKFrequent/2]).

topKFrequent(Nums, K) ->
    Count = count(Nums, #{}),
    Sorted = lists:sort(fun({_, A}, {_, B}) -> A > B end, maps:to_list(Count)),
    TopK = lists:sublist(Sorted, K),
    [Key || {Key, _} <- TopK].

count([], Acc) ->
    Acc;
count([H | T], Acc) ->
    NewAcc = case maps:is_key(H, Acc) of
        true -> maps:update(H, maps:get(H, Acc) + 1, Acc);
        false -> maps:put(H, 1, Acc)
    end,
    count(T, NewAcc).