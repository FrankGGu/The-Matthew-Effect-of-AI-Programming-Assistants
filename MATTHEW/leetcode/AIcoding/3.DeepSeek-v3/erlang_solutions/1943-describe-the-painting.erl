-module(solution).
-export([split_painting/1]).

split_painting(Segments) ->
    Events = lists:foldl(fun([Start, End, Color], Acc) ->
        [{Start, Color, start} | [{End, Color, end} | Acc]]
    end, [], Segments),
    SortedEvents = lists:keysort(1, Events),
    process_events(SortedEvents, 0, 0, [], []).

process_events([], _PrevPos, _CurrentColor, _CurrentList, Result) ->
    lists:reverse(Result);
process_events([{Pos, Color, Type} | Rest], PrevPos, CurrentColor, CurrentList, Result) ->
    case PrevPos < Pos andalso CurrentColor =/= 0 of
        true ->
            NewResult = [[PrevPos, Pos, CurrentColor] | Result],
            NewCurrentList = [];
        false ->
            NewResult = Result,
            NewCurrentList = CurrentList
    end,
    NewCurrentList1 = case Type of
        start -> [Color | NewCurrentList];
        end -> lists:delete(Color, NewCurrentList)
    end,
    NewColor = case NewCurrentList1 of
        [] -> 0;
        _ -> lists:sum(NewCurrentList1)
    end,
    process_events(Rest, Pos, NewColor, NewCurrentList1, NewResult).