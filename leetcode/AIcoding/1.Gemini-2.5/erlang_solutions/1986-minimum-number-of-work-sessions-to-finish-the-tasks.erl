-spec min_sessions(Tasks :: [integer()], SessionTime :: integer()) -> integer().
min_sessions(Tasks, SessionTime) ->
    N = length(Tasks),
    TasksArray = list_to_tuple(Tasks),

    % DP map: Mask -> {NumSessions, LastSessionRemaining}
    % Mask represents the set of tasks already assigned.
    % NumSessions is the minimum number of sessions required for tasks in Mask.
    % LastSessionRemaining is the remaining capacity of the last session used.
    % Initialize with 0 tasks (mask 0) requiring 1 session with full capacity.
    DP = #{0 => {1, SessionTime}},

    % Iterate through all possible masks from 0 to (1 << N) - 1.
    % Masks are processed in increasing order, ensuring that when we consider a Mask,
    % all its sub-masks (representing subsets of tasks) have already been processed
    % and their optimal states are in DP.
    ResultDP = lists:foldl(
        fun(Mask, CurrentDP) ->
            case maps:find(Mask, CurrentDP) of
                {ok, {CurrentSessions, CurrentRemaining}} ->
                    % Iterate through tasks not yet in the current mask
                    lists:foldl(
                        fun(I, InnerDP) ->
                            % Check if task I is already in Mask
                            IfBitSet = Mask band (1 bsl I),
                            if IfBitSet == 0 -> % If task I is NOT in Mask
                                NewMask = Mask bor (1 bsl I), % Add task I to the mask
                                TaskDuration = element(I + 1, TasksArray), % Erlang tuples are 1-indexed

                                % Determine the state if task I is added
                                {CandidateSessions, CandidateRemaining} =
                                    if TaskDuration =< CurrentRemaining ->
                                        % Task fits in the current last session
                                        {CurrentSessions, CurrentRemaining - TaskDuration};
                                    true ->
                                        % Task does not fit, start a new session
                                        {CurrentSessions + 1, SessionTime - TaskDuration}
                                    end,

                                % Get existing result for NewMask, or a default "worst" state
                                % (N + 1 sessions is guaranteed to be worse than any valid solution)
                                {ExistingSessions, ExistingRemaining} = maps:get(NewMask, InnerDP, {N + 1, 0}),

                                % Compare and update if the candidate state is better
                                % A state {S1, R1} is better than {S2, R2} if:
                                % 1. S1 < S2 (fewer sessions)
                                % 2. S1 == S2 AND R1 > R2 (same sessions, but more remaining capacity in the last session,
                                %    which could potentially allow more tasks to fit without starting a new session).
                                if CandidateSessions < ExistingSessions ->
                                    maps:put(NewMask, {CandidateSessions, CandidateRemaining}, InnerDP);
                                   CandidateSessions == ExistingSessions andalso CandidateRemaining > ExistingRemaining ->
                                    maps:put(NewMask, {CandidateSessions, CandidateRemaining}, InnerDP);
                                true ->
                                    InnerDP % No improvement, keep the existing state
                                end;
                            true ->
                                InnerDP % Task I is already in Mask, skip
                            end
                        end,
                        CurrentDP,
                        lists:seq(0, N - 1) % Iterate through all task indices
                    )
                _ ->
                    CurrentDP % Current Mask is not reachable, skip it
            end
        end,
        DP,
        lists:seq(0, (1 bsl N) - 1) % Iterate through all possible masks
    ),

    % The final answer is the number of sessions for the mask representing all tasks.
    % ((1 bsl N) - 1) is the mask with all N bits set.
    {MinSessions, _} = maps:get((1 bsl N) - 1, ResultDP),
    MinSessions.