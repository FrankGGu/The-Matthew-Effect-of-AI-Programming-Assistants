-module(solution).
-export([min_hours/2]).

min_hours(ability, target) ->
    min_hours(ability, target, 0).

min_hours([], _, Hours) ->
    Hours;
min_hours([H | T], Target, Hours) when H >= Target ->
    min_hours(T, Target, Hours);
min_hours([H | T], Target, Hours) ->
    min_hours(T, Target, Hours + (Target - H)).