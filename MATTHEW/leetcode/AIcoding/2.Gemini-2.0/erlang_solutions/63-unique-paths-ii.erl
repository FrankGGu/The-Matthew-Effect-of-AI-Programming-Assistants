-module(unique_paths_ii).
-export([unique_paths_with_obstacles/1]).

unique_paths_with_obstacles(ObstacleGrid) ->
    Rows = length(ObstacleGrid),
    Cols = length(lists:nth(1, ObstacleGrid)),

    case lists:nth(1, lists:nth(1, ObstacleGrid)) == 1 of
        true -> 0;
        false -> solve(ObstacleGrid, Rows, Cols)
    end.

solve(ObstacleGrid, Rows, Cols) ->
    DP = array:new([1, 1], [Rows, Cols], 0),
    array:set(1, 1, DP, 1),

    lists:foreach(
        fun(Row) ->
            lists:foreach(
                fun(Col) ->
                    case lists:nth(Col, lists:nth(Row, ObstacleGrid)) == 1 of
                        true ->
                            array:set(Row, Col, DP, 0);
                        false ->
                            Left = case Col > 1 of
                                true -> array:get(Row, Col - 1, DP);
                                false -> 0
                            end,
                            Up = case Row > 1 of
                                true -> array:get(Row - 1, Col, DP);
                                false -> 0
                            end,
                            array:set(Row, Col, DP, Left + Up)
                    end
                end,
                lists:seq(1, Cols)
            )
        end,
        lists:seq(1, Rows)
    ),

    array:get(Rows, Cols, DP).