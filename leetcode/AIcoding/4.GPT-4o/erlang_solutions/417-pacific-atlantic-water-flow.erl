-module(solution).
-export([pacific_atlantic/1]).

%% Depth-First Search to explore from the ocean and mark reachable cells.
-spec pacific_atlantic([[integer()]]) -> [[integer()]].
pacific_atlantic(Heights) ->
    %% Get the dimensions of the grid.
    {Rows, Cols} = {length(Heights), length(hd(Heights))},
    
    %% Create matrices to keep track of reachable cells.
    Pacific = lists:duplicate(Rows, lists:duplicate(Cols, false)),
    Atlantic = lists:duplicate(Rows, lists:duplicate(Cols, false)),
    
    %% Run DFS from the Pacific and Atlantic boundaries.
    Pacific2 = dfs(Heights, Pacific, 0, 0, Rows, Cols),
    Atlantic2 = dfs(Heights, Atlantic, Rows-1, Cols-1, Rows, Cols),
    
    %% Collect all cells that can reach both oceans.
    lists:foldl(fun({R, C}, Acc) ->
        case {lists:nth(R + 1, Pacific2), lists:nth(C + 1, Atlantic2)} of
            {true, true} -> [[R, C] | Acc];
            _ -> Acc
        end
    end, [], lists:seq(0, Rows-1)).

%% Depth-First Search (DFS) to explore reachable cells from the ocean.
-spec dfs([[integer()]], [[boolean()]], integer(), integer(), integer(), integer()) -> [[boolean()]].
dfs(Heights, Matrix, R, C, Rows, Cols) ->
    %% Return if the cell is out of bounds or already marked.
    if
        R < 0 orelse R >= Rows orelse C < 0 orelse C >= Cols -> Matrix;
        lists:nth(R + 1, lists:nth(C + 1, Matrix)) -> Matrix;
        true ->
            %% Mark the current cell as reachable.
            Matrix2 = lists:map(fun(Row) -> 
                                  if Row == R -> lists:setelement(C + 1, Row, true);
                                     true -> Row end
                               end, Matrix),
            %% Recursively explore neighboring cells (North, South, East, West).
            Matrix3 = dfs(Heights, Matrix2, R - 1, C, Rows, Cols),
            Matrix4 = dfs(Heights, Matrix3, R + 1, C, Rows, Cols),
            dfs(Heights, Matrix4, R, C - 1, Rows, Cols),
            dfs(Heights, Matrix4, R, C + 1, Rows, Cols)
    end.
