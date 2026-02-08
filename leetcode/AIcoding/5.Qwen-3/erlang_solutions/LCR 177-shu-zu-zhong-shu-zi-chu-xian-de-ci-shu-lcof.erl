-module(solution).
-export([num_color_pairs/1]).

num_color_pairs(Colors) ->
    Count = lists:foldl(fun(Color, Acc) -> maps:update_with(Color, fun(V) -> V + 1 end, 1, Acc) end, maps:new(), Colors),
    maps:fold(fun(_, V, Acc) -> Acc + (V * (V - 1) div 2) end, 0, Count).