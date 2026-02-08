-module(solution).
-export([count_odds/2]).

-spec count_odds(Low :: integer(), High :: integer()) -> integer().
count_odds(Low, High) ->
    (High + 1) div 2 - (Low div 2).