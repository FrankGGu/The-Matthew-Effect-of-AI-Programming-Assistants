-module(solution).
-export([running_sum/1]).

running_sum(Input) ->
    lists:foldl(fun(E, Acc) -> Acc ++ [lists:last(Acc) + E] end, [hd(Input)], tl(Input)).