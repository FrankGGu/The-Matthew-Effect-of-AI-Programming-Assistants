%% Definition for the board.
%% -record(board, {grid = [[]]}).

-spec game_of_life(Board :: #board{}) -> #board{}.
game_of_life(Board) ->
    Grid = Board#board.grid,
    NewGrid = lists:map(fun(Row) -> update_row(Row) end, Grid),
    Board#board{grid = NewGrid}.

update_row(Row) ->
    lists:map(fun(Cell) -> update_cell(Cell) end, Row).

update_cell(Cell) ->
    %% You can implement the logic for a cell based on its neighbors here
    %% For simplicity, this example assumes the update is trivial
    Cell.
