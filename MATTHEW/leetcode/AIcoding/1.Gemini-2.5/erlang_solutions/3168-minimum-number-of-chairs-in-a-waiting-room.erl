-module(solution).
-export([min_chairs/1]).

min_chairs(Intervals) ->
    Events = lists:flatmap(fun([Start, End]) -> [{Start, 1}, {End, -1}] end, Intervals),

    SortedEvents = lists:sort(fun({TimeA, TypeA}, {TimeB, TypeB}) ->
                                  if TimeA < TimeB -> true;
                                     TimeA > TimeB -> false;
                                     TimeA == TimeB ->
                                         if TypeA == -1 andalso TypeB == 1 -> true;
                                            TypeA == 1 andalso TypeB == -1 -> false;
                                            true -> true
                                         end
                                  end
                              end, Events),

    element(2, lists:foldl(fun({_Time, Type}, {CurrentChairs, MaxChairs}) ->
                                   NewCurrentChairs = CurrentChairs + Type,
                                   NewMaxChairs = max(MaxChairs, NewCurrentChairs),
                                   {NewCurrentChairs, NewMaxChairs}
                           end, {0, 0}, SortedEvents)).