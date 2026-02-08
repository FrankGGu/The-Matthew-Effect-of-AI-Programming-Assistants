-module(solution).
-export([minimum_deletions/1]).

minimum_deletions(S) ->
    CountA = lists:foldl(fun(Char, Acc) -> Acc + (if Char =:= $a -> 1; true -> 0 end) end, 0, S),
    CountB = length(S) - CountA,
    abs(CountA - CountB).