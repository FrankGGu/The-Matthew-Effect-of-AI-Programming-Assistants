-module(solution).
-export([fillCups/1]).

fillCups(Cups) ->
    Max = lists:max(Cups),
    Sum = lists:sum(Cups),
    max(Max, (Sum + 1) div 2).