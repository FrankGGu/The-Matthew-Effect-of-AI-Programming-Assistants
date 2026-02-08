-module(reschedule_meetings2).
-export([max_available_time/1]).

max_available_time(Meetings) ->
  max_available_time(Meetings, 0).

max_available_time([], Acc) ->
  Acc;
max_available_time(Meetings, Acc) ->
  {BestMeeting, RemainingMeetings} = find_best_meeting(Meetings),
  case BestMeeting of
    none ->
      Acc;
    {Start, End} ->
      NewAcc = max(Acc, End - Start),
      max_available_time(RemainingMeetings, NewAcc)
  end.

find_best_meeting(Meetings) ->
  find_best_meeting(Meetings, none, []).

find_best_meeting([], Best, Remaining) ->
  {Best, Remaining};
find_best_meeting([Meeting | Rest], none, Remaining) ->
  find_best_meeting(Rest, Meeting, Remaining);
find_best_meeting([Meeting | Rest], {BestStart, BestEnd}, Remaining) ->
  {Start, End} = Meeting,
  if End < BestStart then
    find_best_meeting(Rest, Meeting, [{BestStart, BestEnd} | Remaining])
  else if Start > BestEnd then
    find_best_meeting(Rest, {BestStart, BestEnd}, [Meeting | Remaining])
  else
    find_best_meeting(Rest, none, Remaining ++ [{BestStart, BestEnd}, Meeting])
  end.