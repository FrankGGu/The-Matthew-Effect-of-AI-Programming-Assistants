-module(solution).

-export([minDays/1]).

minDays(N) when N =< 0 -> 0;
minDays(N) ->
    minDays_helper(N, 0).

minDays_helper(0, Days) -> Days;
minDays_helper(N, Days) ->
    NewN = N div 2 + N rem 2,
    minDays_helper(NewN, Days + 1).