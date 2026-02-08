-module(solution).
-export([min_groups/1]).

min_groups(Intervals) ->
    Events = lists:flatmap(fun([Start, End]) -> [{Start, 1}, {End, -1}] end, Intervals),
    SortedEvents = lists:sort(fun({C1, T1}, {C2, T2}) ->
                                  if C1 < C2 -> true;
                                     C1 > C2 -> false;
                                     true -> T1 > T2
                                  end
                              end, Events),

    {MaxOverlap, _CurrentOverlap} = lists:foldl(fun({_Coord, Type}, {Max, Current}) ->
                                                    NewCurrent = Current + Type,
                                                    NewMax = max(Max, NewCurrent),
                                                    {NewMax, NewCurrent}
                                                end, {0, 0}, SortedEvents),
    MaxOverlap.