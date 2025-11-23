-module(solution).
-export([consecutive_characters/1]).

consecutive_characters(S) ->
    max_consecutive(S, hd(string:to_list(S)), 0, 0).

max_consecutive([], _, Max, Current) -> 
    max(Max, Current);
max_consecutive([H | T], Prev, Max, Current) ->
    NewCurrent = if H == Prev -> Current + 1; true -> 1 end,
    max_consecutive(T, H, max(Max, NewCurrent), NewCurrent).