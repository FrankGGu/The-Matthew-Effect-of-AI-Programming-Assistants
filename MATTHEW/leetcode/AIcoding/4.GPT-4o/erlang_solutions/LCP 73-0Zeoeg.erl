-module(solution).
-export([camp/2]).

camp(N, M) ->
    lists:foldl(fun(_, Acc) -> 
        {X, Y} = Acc,
        {X + M, Y + N}
    end, {0, 0}, lists:seq(1, N).