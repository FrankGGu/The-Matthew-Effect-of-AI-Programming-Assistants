-module(find_difference).
-export([find_the_difference/2]).

find_the_difference(S, T) ->
    lists:foldl(fun(C, Acc) -> Acc bxor C end, 0, S ++ T).