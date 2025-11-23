-module(kth_distinct_string_in_an_array).
-export([kth_distinct/2]).

kth_distinct(Strs, K) ->
    Count = lists:foldl(fun(El, Acc) -> 
        maps:update_with(El, fun(V) -> V + 1 end, 1, Acc) 
    end, #{}, Strs),
    Filtered = lists:filter(fun(El) -> maps:get(El, Count) == 1 end, Strs),
    case length(Filtered) >= K of
        true -> lists:nth(K, Filtered);
        false -> ""
    end.