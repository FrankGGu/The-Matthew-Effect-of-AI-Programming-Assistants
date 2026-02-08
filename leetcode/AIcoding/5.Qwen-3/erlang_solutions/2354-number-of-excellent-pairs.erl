-module(solution).
-export([max_excellent_pairs/1]).

max_excellent_pairs(Numbers) ->
    Count = lists:foldl(fun(N, Acc) -> 
        Bin = integer_to_binary(N),
        Length = erlang:length(Bin),
        maps:update_with(Length, fun(V) -> V + 1 end, 1, Acc)
    end, maps:new(), Numbers),
    maps:fold(fun(Key, Value, Acc) -> 
        Total = Value * (Value - 1) div 2,
        Acc + Total
    end, 0, Count).