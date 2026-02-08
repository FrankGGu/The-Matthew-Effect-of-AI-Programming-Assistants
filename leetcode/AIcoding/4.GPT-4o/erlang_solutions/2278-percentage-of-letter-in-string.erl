-module(solution).
-export([percentage_letter/2]).

percentage_letter(S, C) ->
    Total = length(S),
    Count = lists:foldl(fun(X, Acc) -> Acc + (if X =:= C -> 1; true -> 0 end) end, 0, S),
    (Count * 100) div Total.