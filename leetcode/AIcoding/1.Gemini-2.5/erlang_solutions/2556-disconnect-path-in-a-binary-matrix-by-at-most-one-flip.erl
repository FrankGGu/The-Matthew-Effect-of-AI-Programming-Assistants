-module(solution).
-export([is_path_disconnected/1]).

dfs_check_path_helper(CurrR, CurrC, MaxR, MaxC, Grid, BlockedSet, VisitedSet) ->
    % Check bounds
    if
        CurrR < 0 orelse CurrR >= MaxR orelse CurrC < 0 orelse CurrC >= MaxC ->
            false;
        true ->
            case lists:nth(CurrR + 1, Grid) of
                Row ->
                    case lists:nth(CurrC + 1, Row) of
                        0 -> false; % Cannot move through a 0
                        1 ->
                            % Check if current cell is blocked or already visited
                            if
                                sets:is_element({CurrR, CurrC}, BlockedSet) ->
                                    false;
                                sets:is_element({CurrR, CurrC}, VisitedSet) ->
                                    false;
                                true ->
                                    % If target reached
                                    if
                                        CurrR == MaxR - 1 andalso CurrC == MaxC - 1 ->
                                            true;
                                        true ->
                                            % Add current cell to visited set
                                            NewVisitedSet = sets:add_element({CurrR, CurrC}, VisitedSet),
                                            % Try moving down
                                            case dfs_check_path_helper(CurrR + 1, CurrC, MaxR, MaxC, Grid, BlockedSet, NewVisitedSet) of
                                                true -> true;
                                                false ->
                                                    % Try moving right
                                                    dfs_check_path_helper(CurrR, CurrC + 1, MaxR, MaxC, Grid, BlockedSet, NewVisitedSet)
                                            end
                                    end
                            end
                    end
            end
    end.

dfs_find_and_mark_path_helper(CurrR, CurrC, MaxR, MaxC, Grid, CurrentPath, VisitedSet) ->
    % Check bounds
    if
        CurrR < 0 orelse CurrR >= MaxR orelse CurrC < 0 orelse CurrC >= MaxC ->
            false;
        true ->
            case lists:nth(CurrR + 1, Grid) of
                Row ->
                    case lists:nth(CurrC + 1, Row) of
                        0 -> false; % Cannot move through a 0
                        1 ->
                            % Check if already visited
                            if
                                sets:is_element({CurrR, CurrC}, VisitedSet) ->
                                    false;
                                true ->
                                    % Add current cell to path and visited set
                                    NewCurrentPath = [{CurrR, CurrC} | CurrentPath],
                                    NewVisitedSet = sets:add_element({CurrR, CurrC}, VisitedSet),

                                    % If target reached
                                    if
                                        CurrR == MaxR - 1 andalso CurrC == MaxC - 1 ->
                                            NewCurrentPath; % Return the path
                                        true ->
                                            % Try moving down
                                            case dfs_find_and_mark_path_helper(CurrR + 1, CurrC, MaxR, MaxC, Grid, NewCurrentPath, NewVisitedSet) of
                                                false ->
                                                    % Try moving right
                                                    dfs_find_and_mark_path_helper(CurrR, CurrC + 1, MaxR, MaxC, Grid, NewCurrentPath, NewVisitedSet);
                                                Path -> Path % Path found
                                            end
                                    end
                            end
                    end
            end
    end.

is_path_disconnected(Grid) ->
    M = length(Grid),
    N = length(hd(Grid)),

    % Edge case: 1x1 grid
    if M == 1 andalso N == 1 ->
        case lists:nth(1, lists:nth(1, Grid)) of
            0 -> true; % Already disconnected if (0,0) is 0
            1 -> false % Cannot disconnect (0,0) as it cannot be flipped
        end;
    true ->
        % Check if start (0,0) or end (M-1, N-1) are initially 0
        case {lists:nth(1, lists:nth(1, Grid)), lists:nth(N, lists:nth(M, Grid))} of
            {0, _} -> true; % Start is 0, no path possible
            {_, 0} -> true; % End is 0, no path possible
            {1, 1} ->
                % Find the first path from (0,0) to (M-1, N-1)
                Path1Result = dfs_find_and_mark_path_helper(0, 0, M, N, Grid, [], sets:new()),

                if Path1Result == false ->
                    true; % No path exists initially, so it's already disconnected
                true ->
                    % Convert Path1Result (list of {R,C} tuples) to a set of cells to block.
                    % Exclude start (0,0) and end (M-1, N-1) as these cannot be flipped.
                    Path1CellsSet = sets:from_list(
                                      lists:filter(
                                        fun({R,C}) -> not (R == 0 andalso C == 0) andalso not (R == M-1 andalso C == N-1) end,
                                        Path1Result
                                      )
                                    ),

                    % Check if a second path exists from (0,0) to (M-1, N-1)
                    % after blocking the intermediate cells of the first path.
                    Path2Exists = dfs_check_path_helper(0, 0, M, N, Grid, Path1CellsSet, sets:new()),

                    if Path2Exists == false ->
                        true; % No second path found. This means all paths share at least one intermediate cell with Path1.
                              % Flipping one such shared cell disconnects all paths.
                    true ->
                        false % A second path (vertex-disjoint from Path1's intermediate cells) exists.
                              % Cannot disconnect both paths by flipping only one cell.
                    end
                end
        end
    end.