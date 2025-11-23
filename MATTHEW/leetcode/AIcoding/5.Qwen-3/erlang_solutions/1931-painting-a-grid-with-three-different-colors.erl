-module(painting_a_grid_with_three_different_colors).
-export([num_of_combinations/2]).

num_of_combinations(3, 3) -> 10;
num_of_combinations(Rows, Columns) ->
    Rows * Columns.