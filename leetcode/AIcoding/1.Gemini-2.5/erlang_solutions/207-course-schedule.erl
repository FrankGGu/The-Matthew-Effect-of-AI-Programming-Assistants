-module(solution).
-export([canFinish/2]).

canFinish(NumCourses, Prerequisites) ->
    AdjList = build_adj_list(NumCourses, Prerequisites),
    VisitedStates = maps:from_list([{I, 0} || I <- lists:seq(0, NumCourses - 1)]), % 0: unvisited, 1: visiting, 2: visited

    can_finish_dfs(0, NumCourses, AdjList, VisitedStates).

can_finish_dfs(Course, NumCourses, AdjList, VisitedStates) when Course < NumCourses ->
    case maps:get(Course, VisitedStates) of
        0 -> % Unvisited
            case dfs(Course, AdjList, VisitedStates) of
                {true, NewVisitedStates} -> % No cycle found starting from this course
                    can_finish_dfs(Course + 1, NumCourses, AdjList, NewVisitedStates);
                {false, _} -> % Cycle found starting from this course
                    false
            end;
        _ -> % Already visited or visiting (from another path)
            can_finish_dfs(Course + 1, NumCourses, AdjList, VisitedStates)
    end;
can_finish_dfs(NumCourses, NumCourses, _AdjList, _VisitedStates) ->
    true. % All courses processed without finding a cycle

dfs(CurrentCourse, AdjList, VisitedStates) ->
    % Mark as visiting
    NewVisitedStates1 = maps:put(CurrentCourse, 1, VisitedStates),

    Neighbors = maps:get(CurrentCourse, AdjList, []),

    {PossibleFromNeighbors, FinalVisitedStatesAfterNeighbors} = 
        lists:foldl(
            fun(Neighbor, {AccPossible, AccVisitedStates}) ->
                case AccPossible of
                    false -> {false, AccVisitedStates}; % Cycle already found, propagate
                    true ->
                        case maps:get(Neighbor, AccVisitedStates) of
                            1 -> % Visiting - cycle detected
                                {false, AccVisitedStates};
                            0 -> % Unvisited - recurse
                                {NeighborPossible, NewVisitedStatesFromNeighbor} = dfs(Neighbor, AdjList, AccVisitedStates),
                                {NeighborPossible, NewVisitedStatesFromNeighbor};
                            2 -> % Visited - skip
                                {true, AccVisitedStates}
                        end
                end
            end,
            {true, NewVisitedStates1}, % Initial accumulator for fold: possible so far, updated states
            Neighbors
        ),

    case PossibleFromNeighbors of
        false ->
            {false, FinalVisitedStatesAfterNeighbors}; % A cycle was found in a sub-path
        true ->
            % No cycle found in neighbors, mark current as visited
            {true, maps:put(CurrentCourse, 2, FinalVisitedStatesAfterNeighbors)}
    end.

build_adj_list(NumCourses, Prerequisites) ->
    % Initialize map with empty lists for all courses
    AdjList = maps:from_list([{I, []} || I <- lists:seq(0, NumCourses - 1)]),

    lists:foldl(
        fun([Course, Prerequisite], AccAdjList) ->
            % Edge from Prerequisite to Course
            % So, Prerequisite's list contains Course
            ExistingList = maps:get(Prerequisite, AccAdjList, []),
            maps:put(Prerequisite, [Course | ExistingList], AccAdjList)
        end,
        AdjList,
        Prerequisites
    ).