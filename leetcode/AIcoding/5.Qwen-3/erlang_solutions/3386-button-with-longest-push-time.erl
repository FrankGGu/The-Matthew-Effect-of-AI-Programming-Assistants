-module(button_with_longest_push_time).
-export([mostRecentTime/1]).

mostRecentTime(ButtonTimes) ->
    lists:foldl(fun({Id, Time}, {MaxId, MaxTime}) ->
        if
            Time > MaxTime -> {Id, Time};
            true -> {MaxId, MaxTime}
        end
    end, {0, 0}, ButtonTimes).