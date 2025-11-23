-module(solution).
-export([minimum_time/1]).

-define(INF, erlang:ph_infinity).

minimum_time(Grid) ->
    M = length(Grid),
    N = length(hd(Grid)),

    % Handle special case for (0,0) to (M-1, N-1) path impossibility
    % As per problem description: "if grid[0][1] > 1 and grid[1][0] > 1
    % (i.e., it is impossible to move from (0,0) to an adjacent cell at time 1),
    % it is impossible to visit the cell (m - 1, n - 1). In this case, return -1."
    % This condition only applies if both (0,1) and (1,0) exist, i.e., M > 1 and N > 1.
    case {M, N} of
        {1, 1} ->
            % Target is (0,0), time is grid[0][0]
            lists:nth(1, hd(Grid));
        {_, _} when M > 1 and N > 1 ->
            % Grid[0][1] is lists:nth(2, lists:nth(1, Grid))
            % Grid[1][0] is lists:nth(1, lists:nth(2, Grid))
            G01 = lists:nth(2, lists:nth(1, Grid)),
            G10 = lists:nth(1, lists:nth(2, Grid)),
            if G01 > 1 and G10 > 1 ->
                -1;
            true ->
                dijkstra(Grid, M, N)
            end;
        _ -> % M=1, N>1 or M>1, N=1 (one dimension is 1)
            dijkstra(Grid, M, N)
    end.

dijkstra(Grid, M, N) ->
    % dist_map: map of {R,C} -> MinTime
    % pq: gb_trees of {Time, R, C} -> true (priority queue ordered by Time)

    StartVal = lists:nth(1, hd(Grid)),
    DistMap = #{ {0,0} => StartVal },
    PQ = gb_trees:insert({StartVal, 0, 0}, true, gb_trees:empty()),

    dijkstra_loop(PQ, DistMap, Grid, M, N).

dijkstra_loop(PQ, DistMap, Grid, M, N) ->
    case gb_trees:is_empty(PQ) of
        true ->
            % If the target (M-1, N-1) was not reached, it won't be in DistMap.
            % Given the problem's specific -1 condition, this path should only be taken
            % if the target is reachable. If not, it means something went wrong or
            % the initial -1 check was not exhaustive (which it should be).
            % For safety, return -1 if target is not found.
            case maps:find({M-1, N-1}, DistMap) of
                {ok, Time} -> Time;
                error -> -1
            end;
        false ->
            {{Time, R, C}, _, PQ1} = gb_trees:take_smallest(PQ),

            % If we already found a shorter path to (R,C), skip this entry
            case maps:find({R, C}, DistMap) of
                {ok, CurrentMinTime} when Time > CurrentMinTime ->
                    dijkstra_loop(PQ1, DistMap, Grid, M, N);
                _ ->
                    % If (R,C) is the target, we have found the minimum time
                    if R == M-1 andalso C == N-1 ->
                        Time;
                    true ->
                        Neighbors = get_neighbors(R, C, M, N),
                        {NewPQ, NewDistMap} = lists:foldl(
                            fun({NR, NC}, {AccPQ, AccDistMap}) ->
                                % Time to arrive at neighbor (NR, NC)
                                ArriveTime = Time + 1,

                                % Get value of Grid[NR][NC] (lists:nth is 1-indexed)
                                NeighborGridVal = lists:nth(NC + 1, lists:nth(NR + 1, Grid)),

                                % Actual time to be at (NR, NC) is max(arrival_time, grid_value)
                                NewTime = erlang:max(ArriveTime, NeighborGridVal),

                                % Check if this is a shorter path to (NR, NC)
                                CurrentNeighborMinTime = maps:get({NR, NC}, AccDistMap, ?INF),

                                if NewTime < CurrentNeighborMinTime ->
                                    UpdatedDistMap = maps:put({NR, NC}, NewTime, AccDistMap),
                                    UpdatedPQ = gb_trees:insert({NewTime, NR, NC}, true, AccPQ),
                                    {UpdatedPQ, UpdatedDistMap};
                                true ->
                                    {AccPQ, AccDistMap}
                                end
                            end,
                            {PQ1, DistMap},
                            Neighbors
                        ),
                        dijkstra_loop(NewPQ, NewDistMap, Grid, M, N)
                    end
            end
    end.

get_neighbors(R, C, M, N) ->
    % Define possible movement directions (Right, Left, Down, Up)
    Dirs = [{0, 1}, {0, -1}, {1, 0}, {-1, 0}],

    lists:filtermap(
        fun({DR, DC}) ->
            NR = R + DR,
            NC = C + DC,
            if NR >= 0 andalso NR < M andalso NC >= 0 andalso NC < N ->
                {true, {NR, NC}};
            true ->
                false
            end
        end,
        Dirs
    ).