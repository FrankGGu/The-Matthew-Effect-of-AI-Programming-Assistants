-module(subrectangle_queries).
-export([init/1, updateSubrectangle/5, getValue/2]).

init(Rectangle) ->
    Rectangle.

updateSubrectangle(Grid, R1, C1, R2, C2, NewValue) ->
    update_rows(Grid, 0, R1, R2, C1, C2, NewValue, []).

update_rows([], _CurrentRow, _R1, _R2, _C1, _C2, _NewValue, Acc) ->
    lists:reverse(Acc);
update_rows([H|T], CurrentRow, R1, R2, C1, C2, NewValue, Acc) when CurrentRow >= R1, CurrentRow =< R2 ->
    UpdatedRow = update_cols(H, 0, C1, C2, NewValue, []),
    update_rows(T, CurrentRow + 1, R1, R2, C1, C2, NewValue, [UpdatedRow|Acc]);
update_rows([H|T], CurrentRow, R1, R2, C1, C2, NewValue, Acc) ->
    update_rows(T, CurrentRow + 1, R1, R2, C1, C2, NewValue, [H|Acc]).

update_cols([], _CurrentCol, _C1, _C2, _NewValue, Acc) ->
    lists:reverse(Acc);
update_cols([H|T], CurrentCol, C1, C2, NewValue, Acc) when CurrentCol >= C1, CurrentCol =< C2 ->
    update_cols(T, CurrentCol + 1, C1, C2, NewValue, [NewValue|Acc]);
update_cols([H|T], CurrentCol, C1, C2, NewValue, Acc) ->
    update_cols(T, CurrentCol + 1, C1, C2, NewValue, [H|Acc]).

getValue(Grid, R, C) ->
    RowList = lists:nth(R + 1, Grid),
    lists:nth(C + 1, RowList).