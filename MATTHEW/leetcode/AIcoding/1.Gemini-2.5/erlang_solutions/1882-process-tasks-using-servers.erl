-module(solution).
-export([assignTasks/2]).

assignTasks(Servers, Tasks) ->
    InitialAvailableServersPQ =
        lists:foldl(
            fun({Weight, Index}, Acc) ->
                gb_trees:insert({Weight, Index}, Index, Acc)
            end,
            gb_trees:empty(),
            lists:zip(Servers, lists:seq(0, length(Servers) - 1))
        ),

    {_, _, _, ReversedResult} =
        lists:foldl(
            fun(TaskProcessingTime, {TaskIndex, AvailableServersPQ, BusyServersPQ, ResultAcc}) ->
                TaskArrivalTime = TaskIndex,

                EffectiveTime =
                    case gb_trees:is_empty(AvailableServersPQ) of
                        true ->
                            {{EarliestFreeTime, _, _}, _} = gb_trees:smallest(BusyServersPQ),
                            EarliestFreeTime;
                        false ->
                            TaskArrivalTime
                    end,

                {UpdatedAvailablePQ, UpdatedBusyPQ} =
                    release_servers_helper(AvailableServersPQ, BusyServersPQ, EffectiveTime),

                {{ServerWeight, ServerIdx}, AvailablePQAfterTake} = gb_trees:take_smallest(UpdatedAvailablePQ),

                ServerAssignedTime = EffectiveTime,
                ServerNextAvailableTime = ServerAssignedTime + TaskProcessingTime,

                NewBusyServersPQ = gb_trees:insert({{ServerNextAvailableTime, ServerWeight, ServerIdx}, ServerIdx}, UpdatedBusyPQ),

                NewTaskIndex = TaskIndex + 1,
                NewResultAcc = [ServerIdx | ResultAcc],

                {NewTaskIndex, AvailablePQAfterTake, NewBusyServersPQ, NewResultAcc}
            end,
            {0, InitialAvailableServersPQ, gb_trees:empty(), []},
            Tasks
        ),
    lists:reverse(ReversedResult)
.

release_servers_helper(AvailablePQ, BusyPQ, CurrentTime) ->
    case gb_trees:is_empty(BusyPQ) of
        true ->
            {AvailablePQ, BusyPQ};
        false ->
            {{FreeTime, Weight, ServerIdx}, _} = gb_trees:smallest(BusyPQ),
            case FreeTime =< CurrentTime of
                true ->
                    {{_, _, _}, BusyPQRest} = gb_trees:take_smallest(BusyPQ),
                    NewAvailablePQ = gb_trees:insert({Weight, ServerIdx}, ServerIdx, AvailablePQ),
                    release_servers_helper(NewAvailablePQ, BusyPQRest, CurrentTime);
                false ->
                    {AvailablePQ, BusyPQ}
            end
    end.