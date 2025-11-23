-module(solution).
-export([count_battleships/1]).

%% Count the number of battleships in the board
-spec count_battleships([[char()]]) -> integer().
count_battleships(Board) ->
    %% Iterate over the board and count the battleships.
    count_battleships(Board, 0, -1, -1).

%% Helper function to traverse the board and count the battleships.
-spec count_battleships([[char()]], integer(), integer(), integer()) -> integer().
count_battleships([], Count, _, _) -> Count;
count_battleships([Row | Rest], Count, Prev_i, Prev_j) ->
    count_battleships(Rest, count_battleships_in_row(Row, Prev_i, Prev_j, Count), Prev_i + 1, 0).

%% Helper function to count battleships in a single row.
-spec count_battleships_in_row([char()], integer(), integer(), integer()) -> integer().
count_battleships_in_row([], _, _, Count) -> Count;
count_battleships_in_row(['.' | Rest], Prev_i, Prev_j, Count) ->
    count_battleships_in_row(Rest, Prev_i, Prev_j + 1, Count);
count_battleships_in_row(['X' | Rest], Prev_i, Prev_j, Count) ->
    if
        %% Check if this is a new battleship.
        (Prev_i == -1 orelse element(Prev_j, Prev_i) == '.') ->
            count_battleships_in_row(Rest, Prev_i, Prev_j + 1, Count + 1);
        true -> 
            count_battleships_in_row(Rest, Prev_i, Prev_j + 1, Count)
    end.
