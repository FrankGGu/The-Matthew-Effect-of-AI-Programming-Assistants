-module(solution).
-export([equal_divisible_pairs/2]).

equal_divisible_pairs(Nums, K) ->
    Count = maps:fold(fun(Key, Val, Acc) -> Acc + (Val * (Val - 1)) div 2 end, 0, count_mods(Nums, K)),
    Count.

count_mods([], _) ->
    maps:new();
count_mods([H | T], K) ->
    Mod = H rem K,
    Maps = count_mods(T, K),
    maps:update_with(Mod, fun(V) -> V + 1 end, 1, Maps).