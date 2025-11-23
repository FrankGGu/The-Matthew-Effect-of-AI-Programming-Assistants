-module(unique_paths_ii).
-export([unique_pathsWithObstacles/1]).

unique_pathsWithObstacles(Grid) ->
    Rows = length(Grid),
    if
        Rows == 0 -> 0;
        true ->
            Cols = length(hd(Grid)),
            DP = array:new({size, Rows}, {default, 0}),
            array:set(0, 0, array:set(0, 0, 0, 0), 0),
            unique_pathsWithObstacles(Grid, DP, 0, 0, Rows, Cols)
    end.

unique_pathsWithObstacles(Grid, DP, Row, Col, Rows, Cols) ->
    if
        Row >= Rows; Col >= Cols -> 0;
        true ->
            case lists:nth(Row + 1, Grid) of
                List when is_list(List) ->
                    Value = lists:nth(Col + 1, List),
                    if
                        Value == 1 -> 0;
                        true ->
                            if
                                Row == 0, Col == 0 -> 1;
                                Row == 0 -> array:get(0, Col - 1, DP);
                                Col == 0 -> array:get(Row - 1, 0, DP);
                                true ->
                                    array:get(Row - 1, Col, DP) + array:get(Row, Col - 1, DP)
                            end
                    end
            end
    end.