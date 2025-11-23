-module(sudoku_solver).
-export([solve_sudoku/1]).

solve_sudoku(Board) ->
    solve(Board).

solve(Board) ->
    case find_empty(Board) of
        {Row, Col} ->
            lists:any(fun(Num) ->
                          is_valid(Board, Row, Col, Num) andalso
                          begin
                              set_value(Board, Row, Col, Num),
                              solve(Board) orelse
                              (set_value(Board, Row, Col, $.), false)
                          end
                      end, lists:seq($1, $9));
        false ->
            true
    end.

find_empty(Board) ->
    find_empty(Board, 0).

find_empty(Board, Row) when Row < 9 ->
    case string:chr(lists:nth(Row + 1, Board), $.) of
        0 ->
            find_empty(Board, Row + 1);
        Col ->
            {Row, Col - 1}
    end;
find_empty(_, _) ->
    false.

is_valid(Board, Row, Col, Num) ->
    not lists:member(Num, get_row(Board, Row)) andalso
    not lists:member(Num, get_col(Board, Col)) andalso
    not lists:member(Num, get_box(Board, Row, Col)).

get_row(Board, Row) ->
    lists:nth(Row + 1, Board).

get_col(Board, Col) ->
    [lists:nth(Col + 1, Row) || Row <- Board].

get_box(Board, Row, Col) ->
    StartRow = (Row div 3) * 3,
    StartCol = (Col div 3) * 3,
    [lists:nth(StartCol + C + 1, lists:nth(StartRow + R + 1, Board)) ||
        R <- lists:seq(0, 2), C <- lists:seq(0, 2)].

set_value(Board, Row, Col, Value) ->
    RowStr = lists:nth(Row + 1, Board),
    NewRowStr = string:substr(RowStr, 1, Col) ++ [Value] ++ string:substr(RowStr, Col + 2),
    set_nth(Row + 1, NewRowStr, Board).

set_nth(1, X, [_|T]) -> [X|T];
set_nth(N, X, [H|T]) -> [H|set_nth(N-1, X, T)].