-module(solution).
-export([assign_tasks/2]).

assign_tasks(Servers, Tasks) ->
    Available = lists:sort([{W, I} || {I, W} <- lists:zip(lists:seq(0, length(Servers) - 1, Servers)]),
    assign_tasks(Tasks, Available, [], [], 0, []).

assign_tasks([], _, _, _, _, Result) ->
    lists:reverse(Result);
assign_tasks([Task | Rest], Available, Busy, TimeHeap, CurrentTime, Result) ->
    {NewAvailable, NewBusy, NewTimeHeap} = update_available(Available, Busy, TimeHeap, CurrentTime),
    case NewAvailable of
        [] ->
            {NextTime, _} = hd(NewTimeHeap),
            assign_tasks([Task | Rest], NewAvailable, NewBusy, NewTimeHeap, NextTime, Result);
        _ ->
            [{Weight, Server} | RemainingAvailable] = NewAvailable,
            NewResult = [Server | Result],
            NewBusy1 = [{Server, CurrentTime + Task} | NewBusy],
            NewTimeHeap1 = insert_time_heap(CurrentTime + Task, Server, NewTimeHeap),
            assign_tasks(Rest, RemainingAvailable, NewBusy1, NewTimeHeap1, CurrentTime, NewResult)
    end.

update_available(Available, Busy, TimeHeap, CurrentTime) ->
    case TimeHeap of
        [] ->
            {Available, Busy, TimeHeap};
        [{Time, _} | _] when Time > CurrentTime ->
            {Available, Busy, TimeHeap};
        _ ->
            {Time, Server} = hd(TimeHeap),
            UpdatedTimeHeap = tl(TimeHeap),
            {Busy1, UpdatedBusy} = lists:partition(fun({S, _}) -> S =:= Server end, Busy),
            case Busy1 of
                [{Server, _}] ->
                    NewAvailable = lists:sort([{W, Server} || {W, S} <- Available, S =/= Server] ++ [{element(1, hd(Busy1)), Server}]),
                    update_available(NewAvailable, UpdatedBusy, UpdatedTimeHeap, CurrentTime);
                _ ->
                    {Available, Busy, TimeHeap}
            end
    end.

insert_time_heap(Time, Server, Heap) ->
    lists:sort([{Time, Server} | Heap]).