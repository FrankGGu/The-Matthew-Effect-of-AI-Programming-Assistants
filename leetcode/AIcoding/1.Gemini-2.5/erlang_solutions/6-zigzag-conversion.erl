-module(solution).
-export([convert/2]).

convert(S, NumRows) ->
    if
        NumRows == 1 ->
            S;
        true ->
            Rows = lists:duplicate(NumRows, []),
            lists:flatten(convert_chars(S, NumRows, 0, down, Rows))
    end.

convert_chars([], _NumRows, _CurrentRow, _Direction, AccRows) ->
    AccRows;
convert_chars([H|T], NumRows, CurrentRow, Direction, AccRows) ->
    NewAccRows = update_rows(AccRows, CurrentRow, H),
    {NextRow, NextDirection} = get_next_state(NumRows, CurrentRow, Direction),
    convert_chars(T, NumRows, NextRow, NextDirection, NewAccRows).

update_rows(Rows, Index, Char) ->
    lists:mapi(fun(I, Row) ->
                   if
                       I == Index -> Row ++ [Char];
                       true -> Row
                   end
               end, Rows).

get_next_state(NumRows, CurrentRow, down) ->
    if
        CurrentRow == NumRows - 1 ->
            {NumRows - 2, up};
        true ->
            {CurrentRow + 1, down}
    end;
get_next_state(NumRows, CurrentRow, up) ->
    if
        CurrentRow == 0 ->
            {1, down};
        true ->
            {CurrentRow - 1, up}
    end.