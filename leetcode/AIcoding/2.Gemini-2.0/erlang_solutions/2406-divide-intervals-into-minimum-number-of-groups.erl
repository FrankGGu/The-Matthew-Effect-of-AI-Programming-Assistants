-module(divide_intervals).
-export([minGroupsForIntervals/1]).

minGroupsForIntervals(Intervals) ->
  {Starts, Ends} = lists:unzip(Intervals),
  SortedStarts = lists:sort(Starts),
  SortedEnds = lists:sort(Ends),
  minGroupsForIntervals(SortedStarts, SortedEnds, 0, 0, 0).

minGroupsForIntervals([], [], _, _, MaxGroups) ->
  MaxGroups;
minGroupsForIntervals(Starts, Ends, StartIndex, EndIndex, CurrentGroups) ->
  case {StartIndex < length(Starts), EndIndex < length(Ends)} of
    {true, true} ->
      case lists:nth(StartIndex + 1, Starts) < lists:nth(EndIndex + 1, Ends) of
        true ->
          minGroupsForIntervals(Starts, Ends, StartIndex + 1, EndIndex, CurrentGroups + 1, max(CurrentGroups + 1, CurrentGroups));
        false ->
          minGroupsForIntervals(Starts, Ends, StartIndex, EndIndex + 1, CurrentGroups - 1, CurrentGroups);
      end;
    {true, false} ->
      minGroupsForIntervals(Starts, Ends, StartIndex + 1, EndIndex, CurrentGroups + 1, max(CurrentGroups + 1, CurrentGroups));
    {false, true} ->
      minGroupsForIntervals(Starts, Ends, StartIndex, EndIndex + 1, CurrentGroups - 1, CurrentGroups);
    {false, false} ->
      MaxGroups
  end.

minGroupsForIntervals(Starts, Ends, StartIndex, EndIndex, CurrentGroups, MaxGroups) ->
    case {StartIndex < length(Starts), EndIndex < length(Ends)} of
        {true, true} ->
            case lists:nth(StartIndex + 1, Starts) =< lists:nth(EndIndex + 1, Ends) of
                true ->
                    minGroupsForIntervals(Starts, Ends, StartIndex + 1, EndIndex, CurrentGroups + 1, max(CurrentGroups + 1, MaxGroups));
                false ->
                    minGroupsForIntervals(Starts, Ends, StartIndex, EndIndex + 1, CurrentGroups - 1, MaxGroups);
            end;
        {true, false} ->
            minGroupsForIntervals(Starts, Ends, StartIndex + 1, EndIndex, CurrentGroups + 1, max(CurrentGroups + 1, MaxGroups));
        {false, true} ->
            minGroupsForIntervals(Starts, Ends, StartIndex, EndIndex + 1, CurrentGroups - 1, MaxGroups);
        {false, false} ->
            MaxGroups
    end.