-module(solution).
-export([min_days/1]).

min_days(Island) ->
    case count_islands(Island) of
        0 -> 0;
        1 -> 1;
        _ -> 2
    end.

count_islands(Island) ->
    {Rows, Cols} = size(Island),
    Visited = lists:duplicate(Rows, lists:duplicate(Cols, false)),
    lists:foldl(fun({Row, Col}, Acc) ->
                    if
                        Island(Row, Col) =:= 1, 
                        not Visited(Row, Col) -> 
                            Acc + 1 + dfs(Island, Visited, Row, Col);
                        true -> 
                            Acc
                    end
                end, 0, lists:seq(0, Rows - 1) -- lists:seq(0, Cols - 1)).

dfs(Island, Visited, Row, Col) ->
    case Visited(Row, Col) of
        true -> Visited;
        false -> 
            Visited1 = lists:replace(Visited, Row, lists:replace(Visited(Row), Col, true)),
            lists:foldl(fun({R, C}, Acc) ->
                            if
                                R >= 0, R < length(Island), 
                                C >= 0, C < length(hd(Island)), 
                                Island(R, C) =:= 1 -> 
                                    dfs(Island, Acc, R, C);
                                true -> 
                                    Acc
                            end
                        end, Visited1, [{Row-1, Col}, {Row+1, Col}, {Row, Col-1}, {Row, Col+1}])
    end.