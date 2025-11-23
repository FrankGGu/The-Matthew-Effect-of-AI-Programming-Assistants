-module(power_of_heroes).
-export([power/1]).

power(Heroes) ->
    power(Heroes, 0, 0).

power([], _, Max) ->
    Max;
power([H | T], Current, Max) ->
    case H of
        'A' -> power(T, Current + 1, max(Max, Current + 1));
        'D' -> power(T, Current - 1, Max);
        _ -> power(T, Current, Max)
    end.