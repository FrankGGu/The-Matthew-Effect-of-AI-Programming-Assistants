-module(valid_path).
-export([has_valid_path/1]).

has_valid_path(Grid) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),
    Visited = orddict:new(),
    has_valid_path_helper(Grid, 0, 0, Rows, Cols, Visited).

has_valid_path_helper(Grid, Row, Col, Rows, Cols, Visited) ->
    if Row < 0 orelse Row >= Rows orelse Col < 0 orelse Col >= Cols ->
        false;
    true ->
        case orddict:is_key({Row, Col}, Visited) of
            true ->
                false;
            false ->
                orddict:store({Row, Col}, true, Visited),
                if Row == Rows - 1 andalso Col == Cols - 1 ->
                    true;
                true ->
                    case lists:nth(Row + 1, Grid) of
                        RowList ->
                            case lists:nth(Col + 1, RowList) of
                                1 ->
                                    has_valid_path_helper(Grid, Row, Col + 1, Rows, Cols, Visited) orelse
                                    has_valid_path_helper(Grid, Row, Col - 1, Rows, Cols, Visited);
                                2 ->
                                    has_valid_path_helper(Grid, Row + 1, Col, Rows, Cols, Visited) orelse
                                    has_valid_path_helper(Grid, Row - 1, Col, Rows, Cols, Visited);
                                3 ->
                                    has_valid_path_helper(Grid, Row, Col - 1, Rows, Cols, Visited) orelse
                                    has_valid_path_helper(Grid, Row + 1, Col, Rows, Cols, Visited);
                                4 ->
                                    has_valid_path_helper(Grid, Row, Col + 1, Rows, Cols, Visited) orelse
                                    has_valid_path_helper(Grid, Row + 1, Col, Rows, Cols, Visited);
                                5 ->
                                    has_valid_path_helper(Grid, Row, Col - 1, Rows, Cols, Visited) orelse
                                    has_valid_path_helper(Grid, Row - 1, Col, Rows, Cols, Visited);
                                6 ->
                                    has_valid_path_helper(Grid, Row, Col + 1, Rows, Cols, Visited) orelse
                                    has_valid_path_helper(Grid, Row - 1, Col, Rows, Cols, Visited)
                            end
                    end
        end
    end.