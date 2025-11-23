-module(solution).
-export([count_pairs/3]).

count_pairs(Points, _, K) when K == 0 ->
    length(Points) * (length(Points) - 1) div 2;
count_pairs(Points, _, K) ->
    Map = lists:foldl(fun([X, Y], Acc) ->
        Key = (X bxor Y) band (K),
        maps:update_with(Key, fun(V) -> V + 1 end, 1, Acc)
    end, #{}, Points),
    maps:fold(fun(_, V, Acc) -> Acc + V * (V - 1) div 2 end, 0, Map).