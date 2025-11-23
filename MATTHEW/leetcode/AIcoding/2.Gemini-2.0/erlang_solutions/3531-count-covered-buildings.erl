-module(count_covered_buildings).
-export([coveredBuildings/1]).

coveredBuildings(ranges) ->
  SortedRanges = lists:sort(ranges),
  coveredBuildings(SortedRanges, []).

coveredBuildings([], Covered) ->
  length(Covered);
coveredBuildings([ [Start, End] | Rest ], Covered) ->
  coveredBuildings(Rest, merge([Start, End], Covered)).

merge([Start, End], []) ->
  [[Start, End]];
merge([Start, End], [[CStart, CEnd] | Rest]) ->
  case End < CStart of
    true ->
      [[Start, End] | [[CStart, CEnd] | Rest]];
    false ->
      case Start > CEnd of
        true ->
          [[CStart, CEnd] | merge([Start, End], Rest)];
        false ->
          NewStart = min(Start, CStart),
          NewEnd = max(End, CEnd),
          merge([NewStart, NewEnd], Rest)
      end
  end.