-module(solution).
-export([min_groups/1]).

min_groups(Intervals) ->
    SortedIntervals = lists:sort(fun({Start1, _}, {Start2, _}) -> Start1 < Start2 end, Intervals),
    min_groups(SortedIntervals, [], 0).

min_groups([], Groups, Max) -> Max;

min_groups([{Start, End} | Rest], Groups, Max) ->
    NewGroups = lists:filter(fun({GStart, GEnd}) -> GEnd < Start end, Groups),
    NewGroup = case NewGroups of
        [] -> [{Start, End} | Groups];
        _ -> [{Start, End} | lists:filter(fun(G) -> G =/= hd(NewGroups) end, Groups)]
    end,
    min_groups(Rest, NewGroup, max(Max, length(NewGroup))).