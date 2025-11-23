-module(solution).
-export([replaceElements/1]).

replaceElements(Arr) ->
    Max = lists:max(Arr),
    replace(Arr, Max).

replace([], _) -> [];
replace([_Last], Max) -> [Max];
replace([H | T], Max) ->
    NewMax = lists:max([H | T]),
    [Max | replace(T, NewMax)].