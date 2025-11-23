-module(solution).
-export([minimumVisitedCells/1]).

minimumVisitedCells(Grid) ->
    R = length(Grid),
    C = length(hd(Grid)),

    % Special case: 1x1 grid
    if R == 1 andalso C == 1 ->
        1;
    true ->
        % Convert grid to array of arrays for O(1) access
        GridArray = array:from_list([array:from_list(Row) || Row <- Grid]),

        % Check if starting cell (0,0) allows any moves
        Val00 = array:get(0, array:get(0, GridArray)),
        if Val00 == 0 ->
            -1; % Cannot move from (0,0) if its value is 0
        true ->
            % dist[r][c] stores min steps to reach (r,c)
            % Initialize with a large number (infinity)
            Infinity = R * C + 1, % Max possible steps + 1
            Dist = array:from_list([array:new({0, C - 1}, {default, Infinity}) || _ <- lists:seq(1, R)]),
            Dist1 = array:set(0, array:set(0, 1, array:get(0, Dist)), Dist), % dist[0][0] = 1

            % next_unvisited_col[r] = smallest c' >= 0 such that (r, c')
            % has not been "covered" by a jump from any (r_prev, c_prev) yet.
            % This helps optimize the neighbor exploration to O(M*N) total.
            NextUnvisitedCol = array:new({0, R - 1}, {default, 0}),
            % next_unvisited_row[c] = smallest r' >= 0 such that (r', c)
            % has not been "covered" by a jump from any (r_prev, c_prev) yet.
            NextUnvisitedRow = array:new({0, C - 1}, {default, 0}),

            Q = queue:in({{0, 0}, 1}, queue:new()), % {{R, C}, Steps}

            bfs(Q, Dist1, GridArray, R, C, Infinity, NextUnvisitedCol, NextUnvisitedRow)
        end
    end.

bfs(Q, Dist, GridArray, MaxR, MaxC, Infinity, NextUnvisitedCol, NextUnvisitedRow) ->
    if queue:is_empty(Q) ->
        -1; % No path found
    true ->
        {value, {{R, C}, Steps}, Q1} = queue:out(Q),

        % If we found a shorter path to (R,C) already, skip
        CurrentDist = array:get(C, array:get(R, Dist)),
        if Steps > CurrentDist ->
            bfs(Q1, Dist, GridArray, MaxR, MaxC, Infinity, NextUnvisitedCol, NextUnvisitedRow);
        true ->
            % Check if target reached
            if R == MaxR - 1 andalso C == MaxC - 1 ->
                Steps;
            true ->
                Val = array:get(C, array:get(R, GridArray)),

                % --- Explore horizontal moves ---
                {FinalQ_H, FinalDist_H, FinalNextUnvisitedCol_H} =
                    explore_horizontal(R, C, Steps, Val, MaxC, Q1, Dist, NextUnvisitedCol),

                % --- Explore vertical moves ---
                {FinalQ_V, FinalDist_V, FinalNextUnvisitedRow_V} =
                    explore_vertical(R, C, Steps, Val, MaxR, FinalQ_H, FinalDist_H, NextUnvisitedRow),

                bfs(FinalQ_V, FinalDist_V, GridArray, MaxR, MaxC, Infinity, FinalNextUnvisitedCol_H, FinalNextUnvisitedRow_V)
            end
        end
    end.

explore_horizontal(R, C, Steps, Val, MaxC, Q, Dist, NextUnvisitedCol) ->
    % Calculate the effective range for this jump
    CurrentNextCol = array:get(R, NextUnvisitedCol),
    StartCol = max(C + 1, CurrentNextCol),
    EndCol = min(C + Val, MaxC - 1),

    % Update NextUnvisitedCol[R] to EndCol + 1.
    % This is because all cells up to EndCol are now "considered" by this jump
    % (either added to queue or found to have a shorter path).
    NewNextUnvisitedCol = array:set(R, EndCol + 1, NextUnvisitedCol),

    {FinalQ, FinalDist} =
        lists:foldl(fun(NC, {AccQ, AccDist}) ->
                            if NC >= MaxC -> % Should not happen due to EndCol check, but for safety
                                {AccQ, AccDist};
                            true ->
                                TargetDist = array:get(NC, array:get(R, AccDist)),
                                if Steps + 1 < TargetDist ->
                                    NewDistR = array:set(NC, Steps + 1, array:get(R, AccDist)),
                                    NewDist = array:set(R, NewDistR, AccDist),
                                    NewQ = queue:in({{R, NC}, Steps + 1}, AccQ),
                                    {NewQ, NewDist};
                                else ->
                                    {AccQ, AccDist}
                                end
                            end
                    end, {Q, Dist}, lists:seq(StartCol, EndCol)),
    {FinalQ, FinalDist, NewNextUnvisitedCol}.

explore_vertical(R, C, Steps, Val, MaxR, Q, Dist, NextUnvisitedRow) ->
    CurrentNextRow = array:get(C, NextUnvisitedRow),
    StartRow = max(R + 1, CurrentNextRow),
    EndRow = min(R + Val, MaxR - 1),

    NewNextUnvisitedRow = array:set(C, EndRow + 1, NextUnvisitedRow),

    {FinalQ, FinalDist} =
        lists:foldl(fun(NR, {AccQ, AccDist}) ->
                            if NR >= MaxR -> % Should not happen due to EndRow check, but for safety
                                {AccQ, AccDist};
                            true ->
                                TargetDist = array:get(C, array:get(NR, AccDist)),
                                if Steps + 1 < TargetDist ->
                                    NewDistC = array:set(C, Steps + 1, array:get(NR, AccDist)),
                                    NewDist = array:set(NR, NewDistC, AccDist),
                                    NewQ = queue:in({{NR, C}, Steps + 1}, AccQ),
                                    {NewQ, NewDist};
                                else ->
                                    {AccQ, AccDist}
                                end
                            end
                    end, {Q, Dist}, lists:seq(StartRow, EndRow)),
    {FinalQ, FinalDist, NewNextUnvisitedRow}.