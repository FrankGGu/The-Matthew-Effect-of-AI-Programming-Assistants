-module(solution).
-export([min_increments/2]).

min_increments(Target, arr) ->
    N = length(Target),
    {Min, _} = lists:foldl(fun({T, A}, {Acc, Last}) ->
        Incr = max(0, T - Last),
        {Acc + Incr, T}
    end, {0, 0}, lists:zip(Target, arr)),
    Min.