-module(solution).
-export([comfortable_humidity/3]).

comfortable_humidity(Readings, MinComfort, MaxComfort) ->
    lists:foldl(fun(Humidity, Count) ->
                    if Humidity >= MinComfort andalso Humidity =< MaxComfort ->
                        Count + 1;
                       true ->
                        Count
                    end
                end, 0, Readings).