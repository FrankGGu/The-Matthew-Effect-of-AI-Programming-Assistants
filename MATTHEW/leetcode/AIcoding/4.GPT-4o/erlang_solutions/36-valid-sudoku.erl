%% -spec is_valid_sudoku(Board :: [[char()]]) -> boolean().
is_valid_sudoku(Board) ->
    rows_valid(Board) andalso columns_valid(Board) andalso sub_boxes_valid(Board).

rows_valid([]) -> true;
rows_valid([Row | Rest]) -> 
    rows_valid(Rest) andalso valid_set(Row).

columns_valid([]) -> true;
columns_valid(Board) -> columns_valid(Board, 0).

columns_valid(_, 9) -> true;
columns_valid(Board, Index) ->
    Col = lists:map(fun(Row) -> lists:nth(Index + 1, Row) end, Board),
    valid_set(Col) andalso columns_valid(Board, Index + 1).

sub_boxes_valid(Board) -> sub_boxes_valid(Board, 0, 0).

sub_boxes_valid(_, 3, 3) -> true;
sub_boxes_valid(Board, RowIndex, ColIndex) ->
    Box = get_sub_box(Board, RowIndex, ColIndex),
    valid_set(Box) andalso
    (if ColIndex < 2 -> sub_boxes_valid(Board, RowIndex, ColIndex + 1);
        RowIndex < 2 -> sub_boxes_valid(Board, RowIndex + 1, 0);
        true -> true
    end).

get_sub_box(Board, RowIndex, ColIndex) ->
    lists:flatten(lists:sublist(Board, RowIndex * 3 + 1, 3)).

valid_set(List) ->
    ValidList = lists:filter(fun(X) -> X /= "." end, List),
    length(ValidList) == length(lists:usort(ValidList)).
