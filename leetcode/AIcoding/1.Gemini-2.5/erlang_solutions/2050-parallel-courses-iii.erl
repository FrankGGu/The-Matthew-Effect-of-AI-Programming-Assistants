-module(solution).
-export([minimum_time/3]).

minimum_time(N, Relations, Time) ->
    % 1. Initialize Dp map: Dp[i] stores the maximum time to complete course i and its prerequisites.
    % Initially, it's just the duration for course i itself.
    % Courses are 1-indexed, Time list is 0-indexed in problem description but lists:nth is 1-indexed.
    % lists:nth(I, Time) correctly retrieves Time[I-1].
    Dp = maps:from_list([{I, lists:nth(I, Time)} || I <- lists:seq(1, N)]),

    % 2. Build adjacency list (graph) and in-degree map.
    % Adj: maps course U to a list of courses V that U is a prerequisite for.
    % InDegree: maps course V to the number of prerequisites it has.
    Adj0 = maps:new(),
    InDegree0 = maps:new(),
    {Adj, InDegree} = lists:foldl(
        fun([U, V], {CurrentAdj, CurrentInDegree}) ->
            NewAdj = maps:update_with(U, fun(L) -> [V | L] end, [V], CurrentAdj),
            NewInDegree = maps:update_with(V, fun(Count) -> Count + 1 end, 1, CurrentInDegree),
            {NewAdj, NewInDegree}
        end,
        {Adj0, InDegree0},
        Relations
    ),

    % Ensure all courses are in InDegree map, even if they have no relations, with 0 in-degree.
    InDegreeFull = lists:foldl(
        fun(I, CurrentInDegree) ->
            maps:update_with(I, fun(X) -> X end, 0, CurrentInDegree)
        end,
        InDegree,
        lists:seq(1, N)
    ),

    % 3. Initialize queue with courses that have no prerequisites (in-degree 0).
    Q0 = queue:new(),
    InitialQ = lists:foldl(
        fun(I, CurrentQ) ->
            case maps:get(I, InDegreeFull) of
                0 -> queue:in(I, CurrentQ);
                _ -> CurrentQ
            end
        end,
        Q0,
        lists:seq(1, N)
    ),

    % 4. Process queue using topological sort.
    % State: {CurrentQ, CurrentDp, CurrentInDegree}
    {_FinalQ, FinalDp, _FinalInDegree} = process_queue(InitialQ, Dp, InDegreeFull, Adj, Time),

    % 5. The answer is the maximum value in the final Dp map.
    lists:max(maps:values(FinalDp)).

process_queue(Q, Dp, InDegree, Adj, Time) ->
    case queue:out(Q) of
        {{value, U}, QRest} ->
            % Get neighbors of U (courses that U is a prerequisite for)
            Neighbors = maps:get(U, Adj, []), % maps:get(Key, Map, Default) handles missing keys

            % Update Dp and InDegree for each neighbor
            {NewDp, NewInDegree, QNext} = lists:foldl(
                fun(V, {CurrentDp, CurrentInDegree, CurrentQ}) ->
                    % NewTimeForV is the total time to complete V if U is its critical prerequisite.
                    NewTimeForV = maps:get(U, CurrentDp) + lists:nth(V, Time),

                    % Update Dp[V] with the maximum time found so far to complete V.
                    UpdatedDp = maps:update(V, fun(CurrentVal) -> max(CurrentVal, NewTimeForV) end, CurrentDp),

                    % Decrement in-degree for V.
                    UpdatedInDegree = maps:update(V, fun(Count) -> Count - 1 end, CurrentInDegree),

                    % If V's in-degree becomes 0, enqueue it.
                    NewQ = case maps:get(V, UpdatedInDegree) of
                               0 -> queue:in(V, CurrentQ);
                               _ -> CurrentQ
                           end,
                    {UpdatedDp, UpdatedInDegree, NewQ}
                end,
                {Dp, InDegree, QRest},
                Neighbors
            ),
            process_queue(QNext, NewDp, NewInDegree, Adj, Time);
        {empty, _} ->
            % Queue is empty, topological sort complete.
            {Q, Dp, InDegree}
    end.