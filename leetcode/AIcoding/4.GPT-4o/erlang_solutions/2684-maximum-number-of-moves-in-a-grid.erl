-module(maximum_number_of_moves_in_a_grid).
-export([max_moves/2]).

max_moves(Grid, K) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),
    Visited = lists:duplicate(Rows, lists:duplicate(Cols, false)),
    max_moves_helper(Grid, K, 0, 0, Visited).

max_moves_helper(_, 0, Row, Col, _) when Row >= 0, Row < Rows, Col >= 0, Col < Cols -> 
    0;
max_moves_helper(Grid, K, Row, Col, Visited) ->
    case lists:nth(Row + 1, Visited) of
        false ->
            Visited1 = lists:update_element(Row + 1, lists:update_element(Col + 1, true, lists:nth(Row + 1, Visited)), Visited),
            Max1 = max_moves_helper(Grid, K - 1, Row + 1, Col, Visited1),
            Max2 = max_moves_helper(Grid, K - 1, Row, Col + 1, Visited1),
            Max3 = max_moves_helper(Grid, K - 1, Row - 1, Col, Visited1),
            Max4 = max_moves_helper(Grid, K - 1, Row, Col - 1, Visited1),
            lists:max([Max1, Max2, Max3, Max4]) + 1;
        _ -> 
            0
    end.