-module(solution).
-export([min_array_length/1]).

min_array_length(Nums) ->
    Count = lists:foldl(fun(N, Acc) -> maps:update_with(N, fun(V) -> V + 1 end, 1, Acc) end, #{}, Nums),
    Pairs = maps:fold(fun(_, V, Acc) -> Acc + (V div 2) end, 0, Count),
    lists:foldl(fun({K, V}, Acc) -> 
        if V rem 2 == 1 -> Acc + 1;
           true -> Acc
        end
    end, 0, Count) + max(0, Pairs - (lists:foldl(fun({_, V}, Acc) -> Acc + (V rem 2) end, 0, Count))).

min_array_length_helper([], _, _) -> 0;
min_array_length_helper([{K, V} | Rest], Pairs, Remaining) ->
    if V rem 2 == 1 -> min_array_length_helper(Rest, Pairs, Remaining + 1);
       true -> min_array_length_helper(Rest, Pairs, Remaining)
    end.