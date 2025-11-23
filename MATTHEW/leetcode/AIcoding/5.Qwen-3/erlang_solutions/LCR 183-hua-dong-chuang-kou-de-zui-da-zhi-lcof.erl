-module(solution).
-export([largest_altitude/1]).

largest_altitude(Changes) ->
    lists:foldl(fun(Change, {Max, Current}) ->
        NewCurrent = Current + Change,
        NewMax = max(Max, NewCurrent),
        {NewMax, NewCurrent}
    end, {0, 0}, Changes) ++ [0] -- [0].