-module(solution).
-export([timeToCrossTheBridge/3]).

-record(worker_data, {l_to_r, pick, r_to_l, put}).

timeToCrossTheBridge(N, K, Time, Needed) ->
    % Convert Time list of lists to an array of worker_data records
    WorkerDataArray = array:from_list(
        lists:map(fun([LtoR, Pick, RtoL, Put]) ->
                          #worker_data{l_to_r = LtoR, pick = Pick, r_to_l = RtoL, put = Put}
                  end, Time)
    ),

    % Convert Needed list to an array for efficient updates
    WorkerNeededArray = array:from_list(Needed),

    % Calculate total items to process
    TargetItems = lists:sum(Needed),

    % Initialize waiting queues and event queue
    % LeftWaiting: gb_trees of {Priority, WorkerIdx} for workers at left bank
    % RightWaiting: gb_trees of {Priority, WorkerIdx} for workers at right bank
    % Priority = LtoR_time + RtoL_time (smaller is higher priority), then WorkerIdx (smaller is higher priority)
    LeftWaiting = gb_trees:empty(),
    RightWaiting = gb_trees:empty(),

    % NextEvents: gb_trees of {Time, Type, WorkerIdx} for scheduled events
    % Types: finish_crossing_LtoR, finish_picking, finish_crossing_RtoL, finish_putting, bridge_free
    NextEvents = gb_trees:empty(),

    % Initially, all workers are at the left bank, waiting to cross
    InitialLeftWaiting = lists:foldl(
        fun(Idx, AccLeftWaiting) ->
            Worker = array:get(Idx, WorkerDataArray),
            Priority = Worker#worker_data.l_to_r + Worker#worker_data.r_to_l,
            gb_trees:insert({Priority, Idx}, AccLeftWaiting)
        end,
        LeftWaiting,
        lists:seq(0, N - 1)
    ),

    % Start the simulation loop
    loop(0, K, 0, TargetItems, InitialLeftWaiting, RightWaiting, WorkerNeededArray, WorkerDataArray, NextEvents).

loop(CurrentTime, BridgesFree, ItemsProcessed, TargetItems, LeftWaiting, RightWaiting, WorkerNeededArray, WorkerDataArray, NextEvents) ->
    if ItemsProcessed == TargetItems ->
        CurrentTime;
    true ->
        % Step 1: Assign bridges to waiting workers (prioritize right-to-left)
        % This step might add new events to NextEvents and change BridgesFree/waiting queues
        {NewEventsAfterAssign, NewBridgesFreeAfterAssign, NewLeftWaitingAfterAssign, NewRightWaitingAfterAssign} =
            assign_bridges_loop(CurrentTime, BridgesFree, LeftWaiting, RightWaiting, WorkerDataArray, NextEvents),

        % Step 2: Determine next time to advance to
        NextEventTime = case gb_trees:is_empty(NewEventsAfterAssign) of
                            true ->
                                % If no more events, and items are not processed, it implies all workers are done
                                % or stuck. For this problem, it means all items are processed.
                                CurrentTime;
                            false ->
                                element(1, gb_trees:min(NewEventsAfterAssign))
                        end,

        % Advance CurrentTime to the next event time, but not backwards
        ActualNextTime = max(CurrentTime, NextEventTime),

        % Step 3: Process all events that occur at or before ActualNextTime
        % This updates all state variables based on completed events
        {FinalEvents, FinalLeftWaiting, FinalRightWaiting, FinalWorkerNeededArray, FinalItemsProcessed, FinalBridgesFree} =
            process_all_events_at_time(ActualNextTime, NewEventsAfterAssign, NewLeftWaitingAfterAssign, NewRightWaitingAfterAssign,
                                       WorkerNeededArray, WorkerDataArray, ItemsProcessed, NewBridgesFreeAfterAssign),

        % Continue the loop with updated state
        loop(ActualNextTime, FinalBridgesFree, FinalItemsProcessed, FinalLeftWaiting, FinalRightWaiting,
             FinalWorkerNeededArray, WorkerDataArray, FinalEvents)
    end.

process_all_events_at_time(Time, Events, LeftWaiting, RightWaiting, WorkerNeededArray, WorkerDataArray, ItemsProcessed, BridgesFree) ->
    if gb_trees:is_empty(Events) ->
        % No more events to process
        {Events, LeftWaiting, RightWaiting, WorkerNeededArray, ItemsProcessed, BridgesFree};
    true ->
        {EventTime, Type, WorkerIdx} = gb_trees:min(Events),
        if EventTime > Time ->
            % All events at or before 'Time' have been processed
            {Events, LeftWaiting, RightWaiting, WorkerNeededArray, ItemsProcessed, BridgesFree};
        true ->
            % Remove the current event from the queue
            Events1 = gb_trees:delete_min(Events),

            % Initialize new state variables with current values
            NewEvents = Events1,
            NewLeftWaiting = LeftWaiting,
            NewRightWaiting = RightWaiting,
            NewWorkerNeededArray = WorkerNeededArray,
            NewItemsProcessed = ItemsProcessed,
            NewBridgesFree = BridgesFree,

            % Process the event based on its type
            {UpdatedEvents, UpdatedLeftWaiting, UpdatedRightWaiting, UpdatedWorkerNeededArray, UpdatedItemsProcessed, UpdatedBridgesFree} =
                case Type of
                    finish_crossing_LtoR ->
                        Worker = array:get(WorkerIdx, WorkerDataArray),
                        EventTimeToAdd = Time + Worker#worker_data.pick,
                        {gb_trees:insert({EventTimeToAdd, finish_picking, WorkerIdx}, NewEvents),
                         NewLeftWaiting, NewRightWaiting, NewWorkerNeededArray, NewItemsProcessed, NewBridgesFree};
                    finish_picking ->
                        Worker = array:get(WorkerIdx, WorkerDataArray),
                        Priority = Worker#worker_data.l_to_r + Worker#worker_data.r_to_l,
                        {NewEvents,
                         NewLeftWaiting, gb_trees:insert({Priority, WorkerIdx}, NewRightWaiting), NewWorkerNeededArray, NewItemsProcessed, NewBridgesFree};
                    finish_crossing_RtoL ->
                        Worker = array:get(WorkerIdx, WorkerDataArray),
                        EventTimeToAdd = Time + Worker#worker_data.put,
                        {gb_trees:insert({EventTimeToAdd, finish_putting, WorkerIdx}, NewEvents),
                         NewLeftWaiting, NewRightWaiting, NewWorkerNeededArray, NewItemsProcessed, NewBridgesFree};
                    finish_putting ->
                        % Decrement needed items for this worker
                        CurrentNeeded = array:get(WorkerIdx, WorkerNeededArray),
                        UpdatedWorkerNeeded = array:set(WorkerIdx, CurrentNeeded - 1, NewWorkerNeededArray),
                        UpdatedItemsProcessed1 = NewItemsProcessed + 1,

                        % If worker still needs to process items, they go back to the left bank
                        if CurrentNeeded - 1 > 0 ->
                            Worker = array:get(WorkerIdx, WorkerDataArray),
                            Priority = Worker#worker_data.l_to_r + Worker#worker_data.r_to_l,
                            {NewEvents, % No new event to schedule, directly add to waiting queue
                             gb_trees:insert({Priority, WorkerIdx}, NewLeftWaiting), % Directly add to left waiting
                             NewRightWaiting, UpdatedWorkerNeeded, UpdatedItemsProcessed1, NewBridgesFree};
                        true ->
                            {NewEvents, NewLeftWaiting, NewRightWaiting, UpdatedWorkerNeeded, UpdatedItemsProcessed1, NewBridgesFree}
                        end;
                    bridge_free ->
                        {NewEvents, NewLeftWaiting, NewRightWaiting, NewWorkerNeededArray, NewItemsProcessed, BridgesFree + 1}
                end,

            % Recursively process the next event at the same time
            process_all_events_at_time(Time, UpdatedEvents, UpdatedLeftWaiting, UpdatedRightWaiting,
                                       UpdatedWorkerNeededArray, WorkerDataArray, UpdatedItemsProcessed, UpdatedBridgesFree)
        end
    end.

assign_bridges_loop(Time, BridgesFree, LeftWaiting, RightWaiting, WorkerDataArray, Events) ->
    if BridgesFree == 0 ->
        % No bridges available
        {Events, BridgesFree, LeftWaiting, RightWaiting};
    true ->
        % Prioritize workers waiting at the right bank
        if not gb_trees:is_empty(RightWaiting) ->
            {Priority, WorkerIdx} = gb_trees:min(RightWaiting), % Get highest priority worker
            RightWaiting1 = gb_trees:delete_min(RightWaiting), % Remove from waiting queue
            BridgesFree1 = BridgesFree - 1, % One less bridge available

            Worker = array:get(WorkerIdx, WorkerDataArray),
            CrossingTime = Worker#worker_data.r_to_l,
            FinishTime = Time + CrossingTime,

            % Schedule bridge to become free and worker to finish crossing R->L
            Events1 = gb_trees:insert({FinishTime, bridge_free, null}, Events),
            Events2 = gb_trees:insert({FinishTime, finish_crossing_RtoL, WorkerIdx}, Events1),

            % Recurse to assign more bridges
            assign_bridges_loop(Time, BridgesFree1, LeftWaiting, RightWaiting1, WorkerDataArray, Events2);

        % If no workers at right bank, check left bank
        else if not gb_trees:is_empty(LeftWaiting) ->
            {Priority, WorkerIdx} = gb_trees:min(LeftWaiting), % Get highest priority worker
            LeftWaiting1 = gb_trees:delete_min(LeftWaiting), % Remove from waiting queue
            BridgesFree1 = BridgesFree - 1, % One less bridge available

            Worker = array:get(WorkerIdx, WorkerDataArray),
            CrossingTime = Worker#worker_data.l_to_r,
            FinishTime = Time + CrossingTime,

            % Schedule bridge to become free and worker to finish crossing L->R
            Events1 = gb_trees:insert({FinishTime, bridge_free, null}, Events),
            Events2 = gb_trees:insert({FinishTime, finish_crossing_LtoR, WorkerIdx}, Events1),

            % Recurse to assign more bridges
            assign_bridges_loop(Time, BridgesFree1, LeftWaiting1, RightWaiting, WorkerDataArray, Events2);

        true ->
            % No workers waiting at either bank, so no more bridges can be assigned
            {Events, BridgesFree, LeftWaiting, RightWaiting}
        end
        end
    end.