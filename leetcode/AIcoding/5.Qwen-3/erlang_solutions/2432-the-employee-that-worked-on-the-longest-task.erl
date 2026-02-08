-module(longest_task).
-export([find_longest_task/1]).

find_longest_task(Workers) ->
    lists:foldl(fun({Id, Start, End}, {MaxId, MaxTime}) ->
        Time = End - Start,
        if
            Time > MaxTime -> {Id, Time};
            true -> {MaxId, MaxTime}
        end
    end, {0, -1}, Workers).