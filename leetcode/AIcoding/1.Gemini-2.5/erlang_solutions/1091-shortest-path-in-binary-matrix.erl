-module(solution).
-export([shortestPathBinaryMatrix/1]).

shortestPathBinaryMatrix(Grid) ->
    N = length(Grid),

    % Check if start or end cell is blocked (value 1)
    % Grid[0][0] is lists:nth(1, lists:nth(1, Grid))
    % Grid[N-1][N-1] is lists:nth(N, lists:nth(N, Grid))
    StartValue = lists:nth(1, lists:nth(1, Grid)),
    EndValue = lists:nth(N, lists:nth(N, Grid)),

    if StartValue == 1 orelse EndValue == 1 ->
        -1;
    N == 1 -> % Special case for 1x1 grid
        if StartValue == 0 -> 1;
        true -> -1
        end;
    true ->
        bfs(Grid, N)
    end.

bfs(Grid, N) ->
    % Queue stores {[R, C], Length}
    Q0 = queue:in({[0, 0], 1}, queue:new()),

    % Visited set stores [R, C] coordinates
    Visited0 = sets:add_element([0, 0], sets:new()),

    % 8-directional neighbors
    Neighbors = [[-1,-1], [-1,0], [-1,1], [0,-1], [0,1], [1,-1], [1,0], [1,1]],

    bfs_loop(Q0, Visited0, Grid, N, Neighbors).

bfs_loop(Q, Visited, Grid, N, Neighbors) ->
    case queue:out(Q) of
        {{value, {[R, C], Len}}, Q_rest} ->
            % Check if target is reached
            if R == N - 1 andalso C == N - 1 ->
                Len;
            true ->
                % Explore neighbors
                {NewQ, NewVisited} = lists:foldl(
                    fun([DR, DC], {AccQ, AccVisited}) ->
                        NR = R + DR,
                        NC = C + DC,

                        % Check if neighbor is within bounds
                        if NR >= 0 andalso NR < N andalso NC >= 0 andalso NC < N ->
                            % Get cell value: Grid[NR][NC]
                            CellValue = lists:nth(NC + 1, lists:nth(NR + 1, Grid)),

                            % Check if not visited and not blocked (value 0)
                            if not sets:is_element([NR, NC], AccVisited) andalso CellValue == 0 ->
                                {queue:in({[NR, NC], Len + 1}, AccQ), sets:add_element([NR, NC], AccVisited)};
                            true ->
                                {AccQ, AccVisited}
                            end;
                        true ->
                            {AccQ, AccVisited}
                        end
                    end,
                    {Q_rest, Visited}, % Start with the rest of the queue and current visited set
                    Neighbors
                ),
                bfs_loop(NewQ, NewVisited, Grid, N, Neighbors)
            end;
        {empty, _} ->
            -1 % No path found
    end.