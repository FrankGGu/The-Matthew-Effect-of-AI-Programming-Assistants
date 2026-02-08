-module(waiting_room).
-export([min_chairs/1]).

min_chairs(Events) ->
    min_chairs(Events, 0, 0).

min_chairs([], Current, Max) ->
    Max;
min_chairs([H | T], Current, Max) ->
    case H of
        "arrive" ->
            min_chairs(T, Current + 1, max(Max, Current + 1));
        "leave" ->
            min_chairs(T, Current - 1, Max)
    end.