-module(solution).
-export([longestIncreasingPath/1]).

longestIncreasingPath(Matrix) ->
    case Matrix of
        [] -> 0;
        _ -> 
            Rows = length(Matrix),
            Cols = length(hd(Matrix)),
            Visited = lists:duplicate(Rows * Cols, false),
            Cache = lists:duplicate(Rows * Cols, -1),
            MaxLength = lists:foldl(fun({Row, Col}, Acc) ->
                case element(Row, lists:element(Col, Matrix)) of
                    [] -> Acc;
                    _ -> 
                        case Cache[element(Row - 1, [0 | lists:seq(1, Cols)]) * Cols + Col] of
                            -1 -> 
                                PathLength = dfs(Matrix, Visited, Cache, Row, Col),
                                lists:max([PathLength, Acc]);
                            Length -> lists:max([Length, Acc])
                        end
                end
            end, 0, lists:seq(1, Rows) ++ lists:seq(1, Cols)),
            MaxLength
    end.

dfs(Matrix, Visited, Cache, Row, Col) ->
    if
        Row < 1 orelse Row > length(Matrix) orelse Col < 1 orelse Col > length(hd(Matrix)) ->
            0;
        Visited[element(Row - 1, [0 | lists:seq(1, length(hd(Matrix)))]) * length(hd(Matrix)) + Col] ->
            Cache[element(Row - 1, [0 | lists:seq(1, length(hd(Matrix)))]) * length(hd(Matrix)) + Col];
        true ->
            Visited1 = lists:replace(Visited, element(Row - 1, [0 | lists:seq(1, length(hd(Matrix)))]) * length(hd(Matrix)) + Col, true),
            Length = 1 + lists:max([
                if
                    Row > 1, hd(Matrix) > element(Row - 2, lists:element(Col, Matrix)) -> dfs(Matrix, Visited1, Cache, Row - 1, Col);
                    Row < length(Matrix), hd(Matrix) < element(Row, lists:element(Col, Matrix)) -> dfs(Matrix, Visited1, Cache, Row + 1, Col);
                    Col > 1, hd(Matrix) > element(Row - 1, lists:element(Col - 2, Matrix)) -> dfs(Matrix, Visited1, Cache, Row, Col - 1);
                    Col < length(hd(Matrix)), hd(Matrix) < element(Row - 1, lists:element(Col, Matrix)) -> dfs(Matrix, Visited1, Cache, Row, Col + 1);
                    true -> 0
                end
            ]),
            Cache1 = lists:replace(Cache, element(Row - 1, [0 | lists:seq(1, length(hd(Matrix)))]) * length(hd(Matrix)) + Col, Length),
            Length
        end
    end.