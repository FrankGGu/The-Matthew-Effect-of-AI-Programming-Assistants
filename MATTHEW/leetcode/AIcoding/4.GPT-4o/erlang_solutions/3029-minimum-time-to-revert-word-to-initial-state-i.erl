-module(solution).
-export([minimum_time/1]).

minimum_time(Str) ->
    Length = length(Str),
    Timer = lists:foldl(fun(_, Acc) -> Acc * 2 end, 1, lists:seq(1, Length)),
    Timer.