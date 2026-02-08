-module(solution).
-export([slowest_key/2]).

slowest_key(Keys, ReleaseTimes) ->
    MaxDuration = lists:foldl(fun({Key, Time}, {Max, MaxKey}) ->
                                    Duration = Time - Max,
                                    if Duration > Max -> {Time, Key};
                                       true -> {Max, MaxKey}
                                    end
                                end, {0, hd(ReleaseTimes)}, lists:zip(Keys, ReleaseTimes)),
    lists:max([Key || {Key, Time} <- lists:zip(Keys, ReleaseTimes), Time - MaxDuration == 0]).