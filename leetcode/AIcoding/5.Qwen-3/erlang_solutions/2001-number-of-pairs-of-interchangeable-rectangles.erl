-module(solution).
-export([num_identical_pairs/1]).

num_identical_pairs(Ret) ->
    CountMap = maps:from_list([{K, 0} || K <- Ret]),
    lists:foldl(fun(Rect, Acc) ->
        {W, H} = Rect,
        Ratio = erlang:round(W / H * 1e6) / 1e6,
        maps:update_with(Ratio, fun(C) -> C + 1 end, 1, Acc)
    end, CountMap, Ret),
    maps:fold(fun(_K, V, Acc) -> Acc + (V * (V - 1)) div 2 end, 0, CountMap).