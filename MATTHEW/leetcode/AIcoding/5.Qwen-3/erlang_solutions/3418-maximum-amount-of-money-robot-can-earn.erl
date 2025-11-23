-module(solution).
-export([max_money/1]).

max_money(Robots) ->
    max_money(Robots, 0, 0).

max_money([], _, Max) ->
    Max;
max_money([H | T], Current, Max) ->
    NewCurrent = Current + H,
    NewMax = max(Max, NewCurrent),
    max_money(T, NewCurrent, NewMax).