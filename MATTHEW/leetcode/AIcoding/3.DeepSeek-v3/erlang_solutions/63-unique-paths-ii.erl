-spec unique_paths_with_obstacles(ObstacleGrid :: [[integer()]]) -> integer().
unique_paths_with_obstacles(ObstacleGrid) ->
    M = length(ObstacleGrid),
    N = length(hd(ObstacleGrid)),
    DP = lists:duplicate(M, lists:duplicate(N, 0)),
    DP1 = case lists:nth(1, lists:nth(1, ObstacleGrid)) of
              0 -> set(1, 1, 1, DP);
              _ -> DP
          end,
    unique_paths_with_obstacles(1, 1, M, N, ObstacleGrid, DP1).

unique_paths_with_obstacles(I, J, M, N, ObstacleGrid, DP) when I > M; J > N ->
    get(M, N, DP);
unique_paths_with_obstacles(I, J, M, N, ObstacleGrid, DP) ->
    case lists:nth(J, lists:nth(I, ObstacleGrid)) of
        1 ->
            NewDP = set(I, J, 0, DP),
            unique_paths_with_obstacles(I + 1, J, M, N, ObstacleGrid, NewDP);
        _ ->
            Up = if I > 1 -> get(I - 1, J, DP); true -> 0 end,
            Left = if J > 1 -> get(I, J - 1, DP); true -> 0 end,
            Val = Up + Left,
            NewDP = set(I, J, Val, DP),
            unique_paths_with_obstacles(I + 1, J, M, N, ObstacleGrid, NewDP)
    end.

get(I, J, DP) ->
    lists:nth(J, lists:nth(I, DP)).

set(I, J, Val, DP) ->
    Row = lists:nth(I, DP),
    NewRow = setnth(J, Val, Row),
    setnth(I, NewRow, DP).

setnth(1, X, [_|T]) -> [X|T];
setnth(N, X, [H|T]) -> [H|setnth(N-1, X, T)].