-module(top_k_frequent).
-export([top_k_frequent/2]).

top_k_frequent(Words, K) ->
    Counts = lists:foldl(fun(W, Acc) -> dict:update_counter(W, 1, Acc) end, dict:new(), Words),
    Pairs = dict:fold(fun(W, C, Acc) -> [{W, C} | Acc] end, [], Counts),
    Sorted = lists:sort(fun({W1, C1}, {W2, C2}) ->
                            if C1 =:= C2 -> W1 < W2;
                               true -> C1 > C2
                            end
                        end, Pairs),
    TopK = lists:sublist(Sorted, K),
    [W || {W, _} <- TopK].