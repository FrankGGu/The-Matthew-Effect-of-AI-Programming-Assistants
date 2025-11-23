-module(solution).
-export([minimum_operations/1]).

minimum_operations(Grid) ->
    YPositions = find_y_positions(Grid),
    Count = count_required_moves(Grid, YPositions),
    Count.

find_y_positions(Grid) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),
    Y = [],
    find_y_positions(Grid, 0, 0, Rows, Cols, Y).

find_y_positions(_, _, Cols, _, Cols, Acc) -> Acc;
find_y_positions(Grid, Row, Col, Rows, Cols, Acc) ->
    case is_y_position(Grid, Row, Col) of
        true -> find_y_positions(Grid, Row, Col + 1, Rows, Cols, [ {Row, Col} | Acc ]);
        false -> find_y_positions(Grid, Row, Col + 1, Rows, Cols, Acc)
    end.

is_y_position(Grid, Row, Col) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),
    Mid = (Rows - 1) div 2,
    if
        Row < Mid andalso Col == Row -> true;
        Row < Mid andalso Col == Cols - 1 - Row -> true;
        Row == Mid andalso Col >= Row andalso Col <= Cols - 1 - Row -> true;
        true -> false
    end.

count_required_moves(Grid, YPositions) ->
    Count = 0,
    count_required_moves(Grid, YPositions, Count).

count_required_moves(_, [], Acc) -> Acc;
count_required_moves(Grid, [{R, C} | Rest], Acc) ->
    Value = lists:nth(C + 1, lists:nth(R + 1, Grid)),
    NewAcc = Acc + (if Value == $y -> 0; true -> 1 end),
    count_required_moves(Grid, Rest, NewAcc).