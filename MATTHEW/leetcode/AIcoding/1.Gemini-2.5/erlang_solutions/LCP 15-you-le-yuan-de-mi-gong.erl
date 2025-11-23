-module(solution).
-export([solve/3]).

solve(Maze, Ball, Hole) ->
    M = length(Maze),
    N = length(hd(Maze)),

    % MinDist: map from {R, C} to {Cost, PathString}
    % PathString is stored as a reversed list of characters for efficient prepending.
    MinDist = maps:new(),

    % PQ: gb_tree where keys are {Cost, PathString, {R, C}}
    % PathString in the key is also reversed.
    % Value can be any term, e.g., true.
    PQ = gb_trees:insert({0, [], Ball}, true, gb_trees:empty()),

    dijkstra(PQ, MinDist, Maze, M, N, Hole).

dijkstra(PQ, MinDist, Maze, M, N, Hole) ->
    case gb_trees:is_empty(PQ) of
        true ->
            "impossible";
        false ->
            {{CurrentCost, CurrentPathReversed, {R, C}}, _, PQ1} = gb_trees:take_smallest(PQ),

            % If we already found a better or equal path to {R, C}, skip
            case maps:find({R, C}, MinDist) of
                {ok, {PrevCost, PrevPathReversed}} when PrevCost < CurrentCost ->
                    dijkstra(PQ1, MinDist, Maze, M, N, Hole);
                {ok, {PrevCost, PrevPathReversed}} when PrevCost == CurrentCost andalso PrevPathReversed =< CurrentPathReversed ->
                    dijkstra(PQ1, MinDist, Maze, M, N, Hole);
                _ ->
                    % Update MinDist
                    MinDist1 = maps:put({R, C}, {CurrentCost, CurrentPathReversed}, MinDist),

                    % If hole reached, return path (reverse it back to original order)
                    if {R, C} == Hole ->
                        lists:reverse(CurrentPathReversed);
                    true ->
                        % Explore neighbors
                        PQ2 = explore_neighbors(R, C, CurrentCost, CurrentPathReversed, PQ1, MinDist1, Maze, M, N, Hole),
                        dijkstra(PQ2, MinDist1, Maze, M, N, Hole)
                    end
            end
    end.

explore_neighbors(R, C, CurrentCost, CurrentPathReversed, PQ, MinDist, Maze, M, N, Hole) ->
    % Directions: {DeltaR, DeltaC, Char}
    Dirs = [
        {{-1, 0}, $u}, % Up
        {{1, 0}, $d},  % Down
        {{0, -1}, $l}, % Left
        {{0, 1}, $r}   % Right
    ],
    lists:foldl(fun({{DR, DC}, DirChar}, AccPQ) ->
        {NextR, NextC, Steps} = roll_ball(R, C, DR, DC, Maze, M, N, Hole),
        NewCost = CurrentCost + Steps,
        NewPathReversed = [DirChar | CurrentPathReversed], % Prepend for efficiency

        case maps:find({NextR, NextC}, MinDist) of
            {ok, {PrevCost, PrevPathReversed}} when PrevCost < NewCost ->
                AccPQ; % Existing path is better (lower cost)
            {ok, {PrevCost, PrevPathReversed}} when PrevCost == NewCost andalso NewPathReversed >= PrevPathReversed ->
                AccPQ; % Existing path is better or equal lexicographically (NewPathReversed >= PrevPathReversed means original path of PrevPathReversed is <= original path of NewPathReversed)
            _ ->
                % New path is better or cell not visited yet, add to PQ
                gb_trees:insert({NewCost, NewPathReversed, {NextR, NextC}}, true, AccPQ)
        end
    end, PQ, Dirs).

roll_ball(StartR, StartC, DR, DC, Maze, M, N, Hole) ->
    roll_ball(StartR, StartC, DR, DC, Maze, M, N, Hole, StartR, StartC, 0).

roll_ball(CurrentR, CurrentC, DR, DC, Maze, M, N, Hole, LastR, LastC, Steps) ->
    NextR = CurrentR + DR,
    NextC = CurrentC + DC,

    % Check if next cell is valid and not a wall
    if
        NextR >= 0, NextR < M, NextC >= 0, NextC < N,
        get_maze_val(NextR, NextC, Maze) == 0 ->
            % If it's the hole, stop rolling here
            if {NextR, NextC} == Hole ->
                {NextR, NextC, Steps + 1};
            true ->
                % Continue rolling
                roll_ball(NextR, NextC, DR, DC, Maze, M, N, Hole, NextR, NextC, Steps + 1)
            end;
        true ->
            % Hit a wall or boundary, stop at LastR, LastC
            {LastR, LastC, Steps}
    end.

get_maze_val(R, C, Maze) ->
    lists:nth(C + 1, lists:nth(R + 1, Maze)).