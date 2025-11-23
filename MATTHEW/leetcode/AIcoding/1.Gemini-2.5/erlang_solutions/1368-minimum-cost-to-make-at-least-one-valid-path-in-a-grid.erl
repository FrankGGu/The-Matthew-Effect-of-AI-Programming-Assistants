-module(solution).
-export([minCost/1]).

minCost(Grid) ->
    M = length(Grid),
    N = length(hd(Grid)),

    %% Define direction vectors for each sign value.
    %% Signs are 1-indexed in the problem (1:right, 2:left, 3:down, 4:up).
    %% Direction vectors are {delta_row, delta_col}.
    DirMap = #{
        1 => {0, 1},  % Right
        2 => {0, -1}, % Left
        3 => {1, 0},  % Down
        4 => {-1, 0}  % Up
    },

    %% Initialize MinCostArray with a large value (infinity).
    %% Max possible cost is M*N (if every step costs 1).
    Infinity = M * N + 1, 

    %% MinCostArray[R][C] stores the minimum cost to reach cell (R, C).
    %% It's an array of arrays.
    InitialRow = array:new(N, Infinity), % A row array initialized with Infinity
    MinCostArray = array:new(M, InitialRow), % An array of these row arrays

    %% Set the cost for the starting cell (0,0) to 0.
    MinCostArray1 = array:set(0, array:set(0, 0, array:get(0, MinCostArray)), MinCostArray),

    %% Initialize the deque for 0-1 BFS.
    %% Queue elements are {Cost, Row, Col}.
    Q = queue:in({0, 0, 0}, queue:new()),

    %% Start the BFS traversal.
    bfs(Q, MinCostArray1, M, N, DirMap, Grid).

bfs(Q, MinCostArray, M, N, DirMap, Grid) ->
    case queue:out(Q) of
        {{value, {Cost, R, C}}, RestQ} ->
            %% If the current cell is the target (M-1, N-1), we found the minimum cost.
            if R == M - 1 andalso C == N - 1 ->
                Cost;
            true ->
                %% Check if we've already found a cheaper path to this cell.
                %% If so, skip processing this path.
                CurrentMinCostForRC = array:get(C, array:get(R, MinCostArray)),
                if Cost > CurrentMinCostForRC ->
                    bfs(RestQ, MinCostArray, M, N, DirMap, Grid);
                true ->
                    %% Get the sign at the current cell (R, C).
                    %% Erlang lists are 1-indexed for `element/2`.
                    Sign = element(C + 1, element(R + 1, Grid)),
                    RequiredDir = maps:get(Sign, DirMap),

                    %% All 4 possible moves: Right, Left, Down, Up.
                    AllDirs = [{0, 1}, {0, -1}, {1, 0}, {-1, 0}],

                    %% Explore all neighbors using `lists:foldl`.
                    %% `AccQ` is the current queue state, `AccMinCostArray` is the current MinCostArray state.
                    {NewQ, NewMinCostArray} = lists:foldl(
                        fun({DR, DC}, {AccQ, AccMinCostArray}) ->
                            NR = R + DR,
                            NC = C + DC,

                            %% Check if the neighbor (NR, NC) is within grid boundaries.
                            if NR >= 0 andalso NR < M andalso NC >= 0 andalso NC < N ->
                                %% Calculate the cost to reach this neighbor.
                                %% 0 if moving according to the sign, 1 otherwise.
                                NewCost = if {DR, DC} == RequiredDir -> Cost;
                                            true -> Cost + 1
                                          end,

                                %% Get the current minimum cost recorded for this neighbor.
                                CurrentNeighborMinCost = array:get(NC, array:get(NR, AccMinCostArray)),

                                %% If a cheaper path to this neighbor is found, update.
                                if NewCost < CurrentNeighborMinCost ->
                                    %% Update MinCostArray for (NR, NC).
                                    MinCostRow = array:get(NR, AccMinCostArray),
                                    UpdatedMinCostRow = array:set(NC, NewCost, MinCostRow),
                                    UpdatedMinCostArray = array:set(NR, UpdatedMinCostRow, AccMinCostArray),

                                    %% Add the neighbor to the front of the queue if cost is 0,
                                    %% or to the back if cost is 1 (0-1 BFS property).
                                    UpdatedQ = if NewCost == Cost ->
                                                    queue:in_r({NewCost, NR, NC}, AccQ); % Add to front
                                                true ->
                                                    queue:in({NewCost, NR, NC}, AccQ)    % Add to back
                                               end,
                                    {UpdatedQ, UpdatedMinCostArray};
                                true ->
                                    %% No improvement, return current state.
                                    {AccQ, AccMinCostArray}
                                end;
                            true ->
                                %% Out of bounds, return current state.
                                {AccQ, AccMinCostArray}
                            end
                        end, {RestQ, MinCostArray}, AllDirs),

                    %% Continue BFS with the updated queue and MinCostArray.
                    bfs(NewQ, NewMinCostArray, M, N, DirMap, Grid)
                end
            end;
        {empty, _} ->
            %% This case should ideally not be reached as the problem guarantees a path exists.
            %% If it were possible for no path to exist, an error or specific value would be returned.
            throw(no_path_found)
    end.