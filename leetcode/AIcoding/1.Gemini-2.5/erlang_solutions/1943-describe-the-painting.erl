-module(leetcode).
-export([describe_the_painting/1]).

describe_the_painting(Strokes) ->
    Events = lists:flatmap(fun([S, E, C]) -> [[S, C], [E, -C]] end, Strokes),

    SortedEvents = lists:sort(fun([C1, _], [C2, _]) -> C1 < C2 end, Events),

    GroupedEventsMap = lists:foldl(fun([Coord, Value], Acc) ->
                                           maps:update_with(Coord, fun(Existing) -> [Value | Existing] end, [Value], Acc)
                                   end, #{}, SortedEvents),

    GroupedEvents = maps:to_list(GroupedEventsMap),

    sweep(GroupedEvents, 0, -1, []).

sweep([], _CurrentSum, _LastCoord, AccResult) ->
    lists:reverse(AccResult);
sweep([{Coord, Values} | Rest], CurrentSum, LastCoord, AccResult) ->
    NewAccResult = 
        if 
            LastCoord =/= -1 andalso Coord > LastCoord andalso CurrentSum > 0 ->
                [[LastCoord, Coord, CurrentSum] | AccResult];
            true ->
                AccResult
        end,

    Change = lists:sum(Values),
    NewCurrentSum = CurrentSum + Change,
    NewLastCoord = Coord,

    sweep(Rest, NewCurrentSum, NewLastCoord, NewAccResult).