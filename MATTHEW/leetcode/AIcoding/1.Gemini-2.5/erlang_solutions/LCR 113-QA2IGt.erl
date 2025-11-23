-module(solution).
-export([findOrder/2]).

-include_lib("kernel/include/logger.hrl"). % Not strictly needed for LeetCode, but good for debugging

findOrder(NumCourses, Prerequisites) ->
    % 1. Initialize Adjacency List (Adj) and In-Degrees (InDegree)
    % Adj: maps course U to a list of courses V that depend on U (V requires U)
    % InDegree: maps course V to its current in-degree
    InitialAdj = maps:from_list([{I, []} || I <- lists:seq(0, NumCourses - 1)]),
    InitialInDegree = maps:from_list([{I, 0} || I <- lists:seq(0, NumCourses - 1)]),

    {Adj, InDegree} = lists:foldl(
        fun([CourseA, CourseB], {CurrentAdj, CurrentInDegree}) ->
            % CourseA requires CourseB, meaning CourseB must be taken before CourseA.
            % So, there's a directed edge from CourseB to CourseA.
            % Add CourseA to the list of neighbors for CourseB.
            NewAdj = maps:update_with(CourseB, fun(Neighbors) -> [CourseA | Neighbors] end, [CourseA], CurrentAdj),
            % Increment in-degree for CourseA.
            NewInDegree = maps:update_with(CourseA, fun(Degree) -> Degree + 1 end, 1, CurrentInDegree),
            {NewAdj, NewInDegree}
        end,
        {InitialAdj, InitialInDegree},
        Prerequisites
    ),

    % 2. Initialize Queue with courses having an in-degree of 0
    Q = queue:new(),
    InitialQ = maps:fold(
        fun(Course, Degree, AccQ) ->
            if Degree == 0 -> queue:in(Course, AccQ);
               true -> AccQ
            end
        end,
        Q,
        InDegree
    ),

    % 3. Perform Topological Sort (Kahn's Algorithm)
    % Result: list of courses in topological order (built in reverse)
    % CurrentInDegree: updated in-degrees map
    % CurrentQ: current queue
    % Count: number of courses processed
    {Result, FinalCount} = topological_sort(InitialQ, InDegree, [], 0, Adj),

    % 4. Check for cycles
    if FinalCount == NumCourses ->
        lists:reverse(Result); % Result was built in reverse order
    true ->
        [] % A cycle exists, impossible to take all courses
    end.

topological_sort(Q, InDegree, AccResult, Count, Adj) ->
    case queue:out(Q) of
        {empty, _} ->
            % Queue is empty, no more courses to process
            {AccResult, Count};
        {{value, U}, NewQ} ->
            % Dequeue a course U
            NewAccResult = [U | AccResult], % Add U to the result list
            NewCount = Count + 1,

            % Get neighbors of U (courses that depend on U)
            Neighbors = maps:get(U, Adj, []), % Default to [] if U has no outgoing edges

            % For each neighbor V of U:
            % Decrement V's in-degree and add to queue if in-degree becomes 0
            {UpdatedQ, UpdatedInDegree} = lists:foldl(
                fun(V, {CurrentQ, CurrentInDegree}) ->
                    % Decrement in-degree of V
                    NewVInDegree = maps:update_with(V, fun(Degree) -> Degree - 1 end, 0, CurrentInDegree),
                    % If in-degree of V becomes 0, enqueue V
                    if maps:get(V, NewVInDegree) == 0 ->
                        {queue:in(V, CurrentQ), NewVInDegree};
                    true ->
                        {CurrentQ, NewVInDegree}
                    end
                end,
                {NewQ, InDegree}, % Start with the queue after U was dequeued and the current InDegree map
                Neighbors
            ),
            % Recurse with the updated queue, in-degrees, result, count, and adjacency list
            topological_sort(UpdatedQ, UpdatedInDegree, NewAccResult, NewCount, Adj)
    end.