-module(solution).
-export([minimum_time_to_visit_a_cell/1]).

minimum_time_to_visit_a_cell(Grid) ->
    M = length(Grid),
    N = length(hd(Grid)),

    % Convert grid to tuple of tuples for O(1) access
    GridTuple = list_to_tuple([list_to_tuple(Row) || Row <- Grid]),

    % Helper function to get cell value
    GetCell = fun(R, C) -> element(C + 1, element(R + 1, GridTuple)) end,

    if M == 1 and N == 1 ->
        0;
    true ->
        IsBlocked01 = (N > 1 and GetCell(0, 1) > 1),
        IsBlocked10 = (M > 1 and GetCell(1, 0) > 1),

        ShouldReturnMinus1 =
            (M > 1 and N > 1 and IsBlocked01 and IsBlocked10) orelse
            (M =:= 1 and N > 1 and IsBlocked01) orelse
            (M > 1 and N =:= 1 and IsBlocked10);

        if ShouldReturnMinus1 ->
            -1;
        true ->
            % Dijkstra initialization
            % Dist map: {{R,C}, Time} stores the minimum time to leave cell {R,C}
            Dist = maps:put({0, 0}, 0, maps:new()),
            % Priority Queue: {Time, {R,C}}
            PQ = gb_trees:insert(0, {0, 0}, gb_trees:empty()),

            dijkstra(PQ, Dist, M, N, GetCell)
        end
    end.

dijkstra(PQ, Dist, M, N, GetCell) ->
    TargetR = M - 1,
    TargetC = N - 1,
    Infinity = 1_000_000_000_000, % A sufficiently large number for unreachable paths

    case gb_trees:is_empty(PQ) of
        true ->
            % If PQ is empty and target not reached, it implies the target is unreachable.
            % According to problem constraints, this should only happen if the -1 condition was not met,
            % but a path still doesn't exist. The problem statement usually implies reachability
            % unless explicitly stated otherwise (like the -1 condition).
            % If it somehow happens, return Infinity (or -1 if problem implies -1 for general unreachability).
            % For this problem, if not caught by -1, it's assumed reachable.
            maps:get({TargetR, TargetC}, Dist, Infinity);
        false ->
            {Time, {R, C}} = gb_trees:min(PQ),
            NewPQ = gb_trees:delete_min(PQ),

            if R == TargetR and C == TargetC ->
                Time; % Reached target, return current time
            true ->
                % Check if we've found a shorter path already
                case maps:get({R, C}, Dist, Infinity) of
                    ExistingTime when ExistingTime < Time ->
                        dijkstra(NewPQ, Dist, M, N, GetCell);
                    _ ->
                        % Process neighbors
                        Neighbors = [{R+1, C}, {R-1, C}, {R, C+1}, {R, C-1}],
                        {UpdatedPQ, UpdatedDist} = lists:foldl(
                            fun({NR, NC}, {AccPQ, AccDist}) ->
                                if
                                    NR >= 0 and NR < M and NC >= 0 and NC < N ->
                                        ArrivalAtNeighbor = Time + 1,
                                        LeaveNeighborTime = max(ArrivalAtNeighbor, GetCell(NR, NC)),

                                        case maps:get({NR, NC}, AccDist, Infinity) of
                                            ExistingNeighborTime when LeaveNeighborTime < ExistingNeighborTime ->
                                                NewAccDist = maps:put({NR, NC}, LeaveNeighborTime, AccDist),
                                                NewAccPQ = gb_trees:insert(LeaveNeighborTime, {NR, NC}, AccPQ),
                                                {NewAccPQ, NewAccDist};
                                            _ ->
                                                {AccPQ, AccDist}
                                        end;
                                    true ->
                                        {AccPQ, AccDist}
                                end
                            end,
                            {NewPQ, Dist},
                            Neighbors
                        ),
                        dijkstra(UpdatedPQ, UpdatedDist, M, N, GetCell)
                end
            end
    end.