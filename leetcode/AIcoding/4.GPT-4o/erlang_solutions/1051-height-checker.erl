-module(height_checker).
-export([height_checker/1]).

height_checker(Heights) ->
    Sorted = lists:sort(Heights),
    lists:foldl(fun({H, S}, Acc) -> if H =:= S -> Acc; true -> Acc + 1 end, 0, lists:zip(Heights, Sorted).