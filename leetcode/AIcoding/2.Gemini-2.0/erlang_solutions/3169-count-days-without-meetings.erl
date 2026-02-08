-module(solution).
-export([count_days_without_meetings/1]).

count_days_without_meetings(meetings) ->
  count_days_without_meetings(meetings, 0, 0).

count_days_without_meetings([], _, Count) ->
  Count;
count_days_without_meetings([[Start, End]|Rest], CurrentDay, Count) ->
  if
    CurrentDay < Start ->
      NewCount = Count + (Start - CurrentDay),
      count_days_without_meetings(Rest, End, NewCount);
    CurrentDay >= Start and CurrentDay < End ->
      count_days_without_meetings(Rest, End, Count);
    CurrentDay >= End ->
      count_days_without_meetings(Rest, CurrentDay, Count)
    end.