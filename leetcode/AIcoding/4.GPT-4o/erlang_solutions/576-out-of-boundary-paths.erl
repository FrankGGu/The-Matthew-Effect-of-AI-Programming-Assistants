-module(out_of_boundary_paths).
-export([find_paths/5]).

find_paths(M, N, maxMove, startRow, startColumn) ->
    Paths = lists:duplicate(M, lists:duplicate(N, -1)),
    find_paths_helper(M, N, maxMove, startRow, startColumn, Paths).

find_paths_helper(_, _, 0, _, _, _) -> 0;
find_paths_helper(M, N, maxMove, row, col, Paths) when row < 0; col < 0; row >= M; col >= N -> 1;
find_paths_helper(M, N, maxMove, row, col, Paths) ->
    case lists:nth(row + 1, lists:nth(col + 1, Paths)) of
        -1 ->
            Paths1 = lists:update_element(row + 1, lists:update_element(col + 1, 0, Paths), Paths),
            Paths2 = lists:update_element(row + 1, lists:update_element(col + 1, find_paths_helper(M, N, maxMove - 1, row - 1, col, Paths1) +
                                                                  find_paths_helper(M, N, maxMove - 1, row + 1, col, Paths1) +
                                                                  find_paths_helper(M, N, maxMove - 1, row, col - 1, Paths1) +
                                                                  find_paths_helper(M, N, maxMove - 1, row, col + 1, Paths1), Paths1), Paths1),
            lists:nth(row + 1, lists:nth(col + 1, Paths2));
        Val -> Val
    end.