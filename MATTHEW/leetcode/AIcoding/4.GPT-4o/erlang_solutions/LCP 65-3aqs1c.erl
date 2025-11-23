-module(solution).
-export([comfortable_humidity/1]).

comfortable_humidity(Humidities) ->
    lists:map(fun(H) -> comfortable_humidity_one(H) end, Humidities).

comfortable_humidity_one(H) when H < 30 -> {false, 30};
comfortable_humidity_one(H) when H > 50 -> {false, 50};
comfortable_humidity_one(H) -> {true, H}.