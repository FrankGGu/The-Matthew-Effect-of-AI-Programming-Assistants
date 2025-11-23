-module(comfortable_humidity).
-export([comfortable_humidity/1]).

comfortable_humidity(temperatures) ->
  comfortable_humidity(temperatures, 0).

comfortable_humidity([], Acc) ->
  Acc;
comfortable_humidity([T|Rest], Acc) ->
  comfortable_humidity(Rest, Acc + comfortable(T)).

comfortable(T) ->
  case T >= 20 and T <= 24 of
    true -> 1;
    false -> 0
  end.