-module(solution).
-export([island_perimeter/1]).

%% Calculate the perimeter of the island represented by the grid.
-spec island_perimeter([[integer()]]) -> integer().
island_perimeter(Grid) ->
    %% For each cell, calculate its contribution to the perimeter.
    lists:foldl(fun({Row, Col}, Acc) ->
                    case lists:concat([up(Row, Col, Grid), down(Row, Col, Grid), left(Row, Col, Grid), right(Row, Col, Grid)]) of
                        [] -> Acc + 4;
                        _ -> Acc - 1
                    end
                end,
                0, 
                enumerate_cells(Grid)).

%% Check if the cell above the current cell is land (1).
up(Row, Col, Grid) ->
    case Row - 1 >= 0 andalso lists:element(Col + 1, lists:nth(Row, Grid)) == 1 of
        true -> [1];
        false -> []
    end.

%% Check if the cell below the current cell is land (1).
down(Row, Col, Grid) ->
    case Row + 1 < length(Grid) andalso lists:element(Col + 1, lists:nth(Row + 2, Grid)) == 1 of
        true -> [1];
        false -> []
    end.

%% Check if the cell to the left of the current cell is land (1).
left(Row, Col, Grid) ->
    case Col - 1 >= 0 andalso lists:element(Col, lists:nth(Row, Grid)) == 1 of
        true -> [1];
        false -> []
    end.

%% Check if the cell to the right of the current cell is land (1).
right(Row, Col, Grid) ->
    case Col + 1 < length(lists:nth(Row, Grid)) andalso lists:element(Col + 2, lists:nth(Row, Grid)) == 1 of
        true -> [1];
        false -> []
    end.

%% Helper function to enumerate all the cells in the grid.
enumerate_cells(Grid) ->
    lists:flatten(
        lists:map(fun(Row) -> 
                        lists:map(fun(Col) -> {Row, Col} end, lists:seq(1, length(Row))) 
                    end, Grid)
    ).
