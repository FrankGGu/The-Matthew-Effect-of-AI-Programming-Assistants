-module(solution).
-export([update_board/2]).

-define(DIRECTIONS, [{-1, 0}, {1, 0}, {0, -1}, {0, 1}, {-1, -1}, {-1, 1}, {1, -1}, {1, 1}]).

%% Public function to update the board.
-spec update_board([[char()]], [integer()]) -> [[char()]].
update_board(Board, [Row, Col]) ->
    case lists:nth(Row + 1, Board) of
        {error, _} -> Board; %% Index out of range
        _ ->
            case lists:nth(Col + 1, lists:nth(Row + 1, Board)) of
                "M" -> update_mine(Board, Row, Col);
                "E" -> update_empty(Board, Row, Col)
            end
    end.

%% Helper function to update the mine (reveal it).
-spec update_mine([[char()]], integer(), integer()) -> [[char()]].
update_mine(Board, Row, Col) ->
    lists:update_element(Row + 1, Board, lists:update_element(Col + 1, lists:nth(Row + 1, Board), "X")).

%% Helper function to update the empty cell (if no adjacent mines, update to "B").
-spec update_empty([[char()]], integer(), integer()) -> [[char()]].
update_empty(Board, Row, Col) ->
    case count_adjacent_mines(Board, Row, Col) of
        0 -> update_blank(Board, Row, Col);
        N -> update_digit(Board, Row, Col, N)
    end.

%% Helper function to count the adjacent mines.
-spec count_adjacent_mines([[char()]], integer(), integer()) -> integer().
count_adjacent_mines(Board, Row, Col) ->
    count_adjacent_mines(Board, Row, Col, 0).

count_adjacent_mines(Board, Row, Col, Acc) ->
    case lists:member({Row, Col}, ?DIRECTIONS) of
        true -> Acc + 1;
        false -> Acc
    end.

%% Helper function to update the blank cell.
-spec update_blank([[char()]], integer(), integer()) -> [[char()]].
update_blank(Board, Row, Col) -> 
    lists:update_element(Row + 1, Board, lists:update_element(Col + 1, lists:nth(Row + 1, Board), "B")).

%% Helper function to update a digit cell.
-spec update_digit([[char()]], integer(), integer(), integer()) -> [[char()]].
update_digit(Board, Row, Col, N) -> 
    lists:update_element(Row + 1, Board, lists:update_element(Col + 1, lists:nth(Row + 1, Board), integer_to_char(N))).
