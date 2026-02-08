-module(solution).
-export([num_equiv_domino_pairs/1]).

num_equiv_domino_pairs(Dominoes) ->
    Count = maps:new(),
    lists:foldl(fun(D, Acc) ->
        {A, B} = D,
        Key = if A < B -> {A, B}; true -> {B, A} end,
        maps:update_with(Key, fun(V) -> V + 1 end, 1, Acc)
    end, Count, Dominoes),
    maps:fold(fun(_, V, Acc) -> Acc + (V * (V - 1)) div 2 end, 0, Count).