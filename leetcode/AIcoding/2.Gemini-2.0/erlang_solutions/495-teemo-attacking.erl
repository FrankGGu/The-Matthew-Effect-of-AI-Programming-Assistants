-module(teemo_attacking).
-export([findPoisonedDuration/2]).

findPoisonedDuration(TimeSeries, Duration) ->
  findPoisonedDuration(TimeSeries, Duration, 0, 0).

findPoisonedDuration([], _Duration, Total, _LastEnd) ->
  Total;
findPoisonedDuration([Time | Rest], Duration, Total, LastEnd) ->
  case LastEnd > Time of
    true ->
      findPoisonedDuration(Rest, Duration, Total + (min(LastEnd, Time + Duration) - LastEnd), Time + Duration);
    false ->
      findPoisonedDuration(Rest, Duration, Total + Duration, Time + Duration)
  end;
findPoisonedDuration([Time], Duration, Total, _LastEnd) ->
  Total + Duration.