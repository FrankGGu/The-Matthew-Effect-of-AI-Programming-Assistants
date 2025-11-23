-module(slide_window_max).
-export([max_sliding_window/2]).

max_sliding_window(Nums, K) ->
    Len = length(Nums),
    Result = lists:seq(1, Len - K + 1),
    lists:map(fun(I) -> get_max(Nums, I, I + K - 1) end, Result).

get_max(List, Start, End) ->
    lists:max(lists:sublist(List, Start, End - Start + 1)).