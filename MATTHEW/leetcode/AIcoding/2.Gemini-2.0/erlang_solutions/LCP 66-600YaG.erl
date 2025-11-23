-module(min_booths).
-export([min_booths/1]).

min_booths(Schedules) ->
  SortedStartTimes = lists:sort([Start || {Start, _} <- Schedules]),
  SortedEndTimes = lists:sort([End || {_, End} <- Schedules]),

  min_booths_helper(SortedStartTimes, SortedEndTimes, 0, 0, 0).

min_booths_helper([], [], BoothsUsed, MaxBooths, _EndTimeIndex) ->
  max(BoothsUsed, MaxBooths);
min_booths_helper([], _Ends, BoothsUsed, MaxBooths, _EndTimeIndex) ->
  max(BoothsUsed, MaxBooths);
min_booths_helper(_Starts, [], BoothsUsed, MaxBooths, _EndTimeIndex) ->
  max(BoothsUsed, MaxBooths);
min_booths_helper([Start | RestStarts], [End | RestEnds], BoothsUsed, MaxBooths, EndTimeIndex) ->
  case Start < End of
    true ->
      min_booths_helper(RestStarts, [End | RestEnds], BoothsUsed + 1, max(BoothsUsed + 1, MaxBooths), EndTimeIndex);
    false ->
      min_booths_helper([Start | RestStarts], RestEnds, BoothsUsed - 1, max(BoothsUsed - 1, MaxBooths), EndTimeIndex + 1)
  end.