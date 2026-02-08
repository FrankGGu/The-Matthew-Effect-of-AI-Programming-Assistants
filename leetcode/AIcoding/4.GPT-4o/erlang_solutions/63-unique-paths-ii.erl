%% -spec unique_paths_with_obstacles(ObstacleGrid :: [[integer()]]) -> integer().
unique_paths_with_obstacles(ObstacleGrid) ->
    unique_paths_with_obstacles(ObstacleGrid, length(ObstacleGrid), length(hd(ObstacleGrid))).

-spec unique_paths_with_obstacles([[integer()]], integer(), integer()) -> integer().
unique_paths_with_obstacles(_, 0, _) -> 0;
unique_paths_with_obstacles(_, _, 0) -> 0;
unique_paths_with_obstacles([[1 | _] | _], _, _) -> 0;
unique_paths_with_obstacles(ObstacleGrid, M, N) ->
    dp(ObstacleGrid, M, N, []).

-spec dp([[integer()]], integer(), integer(), [[integer()]]) -> integer().
dp(_, 0, 0, _) -> 1;
dp(ObstacleGrid, 0, _ , _) -> 0;
dp(ObstacleGrid, _, 0, _) -> 0;
dp([[1 | _] | _], _, _, _) -> 0;
dp(ObstacleGrid, M, N, _) ->
    PrevRow = hd(ObstacleGrid),
    PrevValue = PrevRow(N-1),
    dp(ObstacleGrid, M, N-1, PrevValue) + dp(ObstacleGrid, M-1, N, 0).
