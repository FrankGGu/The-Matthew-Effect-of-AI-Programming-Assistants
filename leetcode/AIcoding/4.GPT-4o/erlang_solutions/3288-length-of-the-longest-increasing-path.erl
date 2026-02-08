-module(solution).
-export([longestIncreasingPath/1]).

longestIncreasingPath(Matrix) when is_list(Matrix) ->
    case Matrix of
        [] -> 0;
        _ -> 
            Rows = length(Matrix),
            Cols = length(hd(Matrix)),
            Visited = lists:duplicate(Rows * Cols, false),
            Memo = lists:duplicate(Rows * Cols, -1),
            MaxLength = lists:foldl(fun({X, Y}, Acc) ->
                Max = max(Acc, dfs(Matrix, Visited, Memo, X, Y, Rows, Cols)),
                Max
            end, 0, lists:cartesian_product(lists:seq(0, Rows - 1), lists:seq(0, Cols - 1))),
            MaxLength
    end.

dfs(Matrix, Visited, Memo, X, Y, Rows, Cols) ->
    case is_valid(X, Y, Rows, Cols, Visited, Matrix) of
        false -> 0;
        true ->
            Index = X * Cols + Y,
            case Memo[Index] of
                -1 ->
                    Visited = lists:update_element(Index + 1, true, Visited),
                    Lengths = [dfs(Matrix, Visited, Memo, X + Dx, Y + Dy, Rows, Cols) || {Dx, Dy} <- [{1, 0}, {0, 1}, {-1, 0}, {0, -1}]],
                    Visited = lists:update_element(Index + 1, false, Visited),
                    MaxLength = 1 + lists:max(Lengths),
                    Memo = lists:update_element(Index + 1, MaxLength, Memo),
                    MaxLength;
                Length -> Length
            end
    end.

is_valid(X, Y, Rows, Cols, Visited, Matrix) ->
    Index = X * Cols + Y,
    X >= 0, X < Rows, Y >= 0, Y < Cols,
    case Visited[Index + 1] of
        true -> false;
        false -> true
    end.

cartesian_product([], _) -> [];
cartesian_product(_, []) -> [];
cartesian_product([H1|T1], L2) ->
    [{H1, H2} || H2 <- L2] ++ cartesian_product(T1, L2).