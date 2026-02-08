-module(solution).
-export([solve/3]).

solve(N, Times, Dependencies) ->
    % Handle N=0 case explicitly, no tasks means 0 time
    if N == 0 -> 0;
       true ->
            % Convert Times list to an array for O(1) access
            TimesArr = array:from_list(Times),

            % Initialize adjacency list and in-degree map for all tasks (0 to N-1)
            InitialAdj = maps:from_list([{I, []} || I <- lists:seq(0, N-1)]),
            InitialInDegree = maps:from_list([{I, 0} || I <- lists:seq(0, N-1)]),

            % Populate Adj and InDegree maps based on dependencies
            % Adj: map Task -> list of its direct successors
            % InDegree: map Task -> count of its direct predecessors
            {Adj, InDegree} = lists:foldl(
                fun([U, V], {AccAdj, AccInDegree}) ->
                    NewAdj = maps:update_with(U, fun(List) -> [V | List] end, [V], AccAdj),
                    NewInDegree = maps:update_with(V, fun(Count) -> Count + 1 end, 1, AccInDegree),
                    {NewAdj, NewInDegree}
                end,
                {InitialAdj, InitialInDegree},
                Dependencies
            ),

            % MaxPrereqFinishTime: map Task -> max finish time of its direct prerequisites
            % Initialize to 0 for all tasks, as no prerequisites mean they start at time 0
            MaxPrereqFinishTime = maps:from_list([{I, 0} || I <- lists:seq(0, N-1)]),

            % Initialize queue for topological sort with tasks having 0 in-degree
            Q = lists:foldl(
                fun(Task, AccQ) ->
                    case maps:get(Task, InDegree) of
                        0 -> queue:in(Task, AccQ);
                        _ -> AccQ
                    end
                end,
                queue:new(),
                lists:seq(0, N-1)
            ),

            % Perform topological sort (Kahn's algorithm) and calculate earliest finish times
            % State: {CurrentQueue, CurrentMaxPrereqFinishTime, CurrentInDegree, MaxOverallFinishTime}
            {_FinalQ, _FinalMaxPrereqFinishTime, _FinalInDegree, MaxTotalTime} = lists:foldl(
                fun(_Dummy, {CurrentQ, CurrentMPFT, CurrentInDegreeState, CurrentMaxTotalTime}) ->
                    case queue:out(CurrentQ) of
                        {empty, _} ->
                            % If the queue becomes empty before processing all N tasks,
                            % it implies a cycle in the graph, which is not expected for this problem type.
                            % Or, if all tasks have been processed, the loop will continue N times,
                            % but queue will be empty.
                            {CurrentQ, CurrentMPFT, CurrentInDegreeState, CurrentMaxTotalTime};
                        {value, U, NewQ} ->
                            TaskDuration = array:get(U, TimesArr),
                            PrereqMaxFinish = maps:get(U, CurrentMPFT),
                            EarliestFinishTimeU = TaskDuration + PrereqMaxFinish,

                            NewMaxTotalTime = max(CurrentMaxTotalTime, EarliestFinishTimeU),

                            % Update successors' MaxPrereqFinishTime and InDegree
                            {UpdatedMPFT, UpdatedInDegreeState, UpdatedQ} = lists:foldl(
                                fun(V, {AccMPFT, AccInDegree, AccQ}) ->
                                    % Update MaxPrereqFinishTime for successor V
                                    NewMPFT_V = max(maps:get(V, AccMPFT), EarliestFinishTimeU),
                                    % Decrement in-degree for successor V
                                    NewInDegree_V = maps:get(V, AccInDegree) - 1,

                                    NewAccMPFT = maps:put(V, NewMPFT_V, AccMPFT),
                                    NewAccInDegree = maps:put(V, NewInDegree_V, AccInDegree),

                                    % If in-degree of V becomes 0, add it to the queue
                                    NewAccQ = if NewInDegree_V == 0 -> queue:in(V, AccQ);
                                                 true -> AccQ
                                              end,
                                    {NewAccMPFT, NewAccInDegree, NewAccQ}
                                end,
                                {CurrentMPFT, CurrentInDegreeState, NewQ}, % Pass current state for successors
                                maps:get(U, Adj) % Iterate over direct successors of U
                            ),
                            {UpdatedQ, UpdatedMPFT, UpdatedInDegreeState, NewMaxTotalTime}
                    end
                end,
                {Q, MaxPrereqFinishTime, InDegree, 0}, % Initial state for the foldl
                lists:seq(1, N) % Iterate N times to process all tasks
            ),
            MaxTotalTime
    end.