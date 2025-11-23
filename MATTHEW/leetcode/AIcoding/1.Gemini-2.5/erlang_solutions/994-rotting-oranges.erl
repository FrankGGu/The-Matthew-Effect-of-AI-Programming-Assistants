-module(rotting_oranges).
-export([rotting_oranges/1]).

rotting_oranges(Grid) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),

    InitialFresh = 0,
    InitialQueue = [],
    InitialVisited = gb_sets:new(), % Stores coordinates of all rotting oranges

    % First pass: count fresh oranges and initialize the queue with rotting ones
    {FinalFresh, FinalQueue, FinalVisited} = 
        lists:foldl(
            fun(R_idx, {AccFresh, AccQueue, AccVisited}) ->
                Row = element(R_idx + 1, Grid), % Get the R_idx-th row (1-indexed)
                lists:foldl(
                    fun(C_idx, {InnerAccFresh, InnerAccQueue, InnerAccVisited}) ->
                        Val = element(C_idx + 1, Row), % Get the C_idx-th element in the row (1-indexed)
                        case Val of
                            1 -> {InnerAccFresh + 1, InnerAccQueue, InnerAccVisited};
                            2 -> {InnerAccFresh, [{R_idx, C_idx} | InnerAccQueue], gb_sets:add_element({R_idx, C_idx}, InnerAccVisited)};
                            _ -> {InnerAccFresh, InnerAccQueue, InnerAccVisited}
                        end
                    end,
                    {AccFresh, AccQueue, AccVisited},
                    lists:seq(0, Cols - 1)
                )
            end,
            {InitialFresh, InitialQueue, InitialVisited},
            lists:seq(0, Rows - 1)
        ),

    % If there are no fresh oranges initially, 0 minutes are needed.
    % The BFS function handles cases where fresh oranges remain but cannot be rotted.
    bfs(lists:reverse(FinalQueue), FinalFresh, 0, FinalVisited, Grid, Rows, Cols).

bfs([], FreshCount, Minutes, _VisitedCells, _Grid, _Rows, _Cols) ->
    % If the queue is empty, no more oranges can rot.
    % If FreshCount is 0, all oranges rotted. Otherwise, some fresh oranges are unreachable.
    case FreshCount of
        0 -> Minutes;
        _ -> -1
    end;
bfs(Queue, FreshCount, Minutes, VisitedCells, Grid, Rows, Cols) ->
    Neighbors = [{0, 1}, {0, -1}, {1, 0}, {-1, 0}], % Delta R, Delta C for 4-directional neighbors

    % Process all oranges in the current 'Queue' level (representing one minute)
    {UpdatedNextQueue, UpdatedFreshCount, UpdatedVisitedCells} = 
        lists:foldl(
            fun({R, C}, {AccNextQ, AccFresh, AccVisited}) ->
                lists:foldl(
                    fun({DR, DC}, {InnerAccNextQ, InnerAccFresh, InnerAccVisited}) ->
                        NR = R + DR,
                        NC = C + DC,

                        % Check if neighbor is within grid bounds and not already visited/rotting
                        if
                            NR >= 0 andalso NR < Rows andalso
                            NC >= 0 andalso NC < Cols andalso
                            not gb_sets:is_element({NR, NC}, InnerAccVisited)
                        ->
                            % Get the value from the original grid (it's immutable)
                            CellVal = element(NC + 1, element(NR + 1, Grid)),
                            case CellVal of
                                1 -> % It's a fresh orange, now it rots
                                    {[{NR, NC} | InnerAccNextQ], InnerAccFresh - 1, gb_sets:add_element({NR, NC}, InnerAccVisited)};
                                _ -> % Not a fresh orange (0 or 2), or already rotted, ignore
                                    {InnerAccNextQ, InnerAccFresh, InnerAccVisited}
                            end;
                            true -> % Out of bounds or already visited/rotting
                                {InnerAccNextQ, InnerAccFresh, InnerAccVisited}
                        end
                    end,
                    {AccNextQ, AccFresh, AccVisited},
                    Neighbors
                )
            end,
            {[], FreshCount, VisitedCells}, % Initial accumulators for this minute's processing
            Queue
        ),

    % After processing all oranges in the current minute's queue:
    case UpdatedNextQueue of
        [] -> % No new oranges rotted in this minute
            case UpdatedFreshCount of
                0 -> Minutes; % All fresh oranges have rotted
                _ -> -1      % Some fresh oranges remain but cannot be reached
            end;
        _ -> % New oranges rotted, continue BFS to the next minute
            bfs(lists:reverse(UpdatedNextQueue), UpdatedFreshCount, Minutes + 1, UpdatedVisitedCells, Grid, Rows, Cols)
    end.