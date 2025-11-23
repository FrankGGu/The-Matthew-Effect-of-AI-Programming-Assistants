-module(solution).
-export([num_special_equivalent/1]).

num_special_equivalent(Strs) ->
    lists:foldl(fun(Str, Acc) ->
        Key = get_key(Str),
        maps:update_with(Key, fun(V) -> V + 1 end, 1, Acc)
    end, maps:new(), Strs),
    maps:size(Acc).

get_key(Str) ->
    Even = lists:sort([lists:nth(I, Str) || I <- lists:seq(1, length(Str), 2)]),
    Odd = lists:sort([lists:nth(I, Str) || I <- lists:seq(2, length(Str), 2)]),
    {Even, Odd}.