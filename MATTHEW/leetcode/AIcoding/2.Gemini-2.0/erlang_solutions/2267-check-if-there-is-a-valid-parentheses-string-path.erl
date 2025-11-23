-module(valid_parentheses_path).
-export([solve/1]).

solve(Grid) ->
    Rows = length(Grid),
    Cols = length(lists:nth(1, Grid)),
    if (Rows + Cols - 1) rem 2 == 0 ->
        false;
    true ->
        valid_path(Grid, 0, 0, 0, Rows, Cols)
    end.

valid_path(_Grid, Row, Col, Balance, Rows, Cols) when Row >= Rows orelse Col >= Cols ->
    false;
valid_path(Grid, Row, Col, Balance, Rows, Cols) ->
    Char = lists:nth(Col+1, lists:nth(Row+1, Grid)),
    NewBalance = case Char of
        '(' ->
            Balance + 1;
        ')' ->
            Balance - 1
    end,
    if NewBalance < 0 ->
        false;
    Row == Rows - 1 andalso Col == Cols - 1 ->
        NewBalance == 0;
    true ->
        (valid_path(Grid, Row+1, Col, NewBalance, Rows, Cols) orelse
         valid_path(Grid, Row, Col+1, NewBalance, Rows, Cols))
    end.