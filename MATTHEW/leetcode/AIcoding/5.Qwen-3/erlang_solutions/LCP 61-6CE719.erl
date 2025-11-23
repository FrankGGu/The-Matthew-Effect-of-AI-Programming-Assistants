-module(temperature_trend).
-export([temperatureTrend/1]).

temperatureTrend(Temperatures) ->
    temperatureTrend(Temperatures, []).

temperatureTrend([], Result) ->
    lists:reverse(Result);
temperatureTrend([_], Result) ->
    lists:reverse(Result);
temperatureTrend([A, B | Rest], Result) ->
    if
        A < B -> temperatureTrend([B | Rest], ["Increasing" | Result]);
        A > B -> temperatureTrend([B | Rest], ["Decreasing" | Result]);
        true -> temperatureTrend([B | Rest], ["Same" | Result])
    end.