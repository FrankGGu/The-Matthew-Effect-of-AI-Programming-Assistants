-spec champagne_tower(Poured :: integer(), Query_row :: integer(), Query_glass :: integer()) -> float().
champagne_tower(Poured, Query_row, Query_glass) ->
    Tower = lists:duplicate(100, lists:duplicate(100, 0.0)),
    Tower1 = set_row_glass(Tower, 0, 0, Poured),
    Result = get_row_glass(Tower1, Query_row, Query_glass),
    min(1.0, Result).

set_row_glass(Tower, Row, Glass, Amount) ->
    Current = get_row_glass(Tower, Row, Glass),
    NewAmount = Current + Amount,
    if
        NewAmount =< 1.0 ->
            set_row_glass_value(Tower, Row, Glass, NewAmount);
        true ->
            Overflow = NewAmount - 1.0,
            Half = Overflow / 2.0,
            Tower1 = set_row_glass_value(Tower, Row, Glass, 1.0),
            Tower2 = set_row_glass(Tower1, Row + 1, Glass, Half),
            set_row_glass(Tower2, Row + 1, Glass + 1, Half)
    end.

get_row_glass(Tower, Row, Glass) ->
    RowList = lists:nth(Row + 1, Tower),
    lists:nth(Glass + 1, RowList).

set_row_glass_value(Tower, Row, Glass, Value) ->
    RowList = lists:nth(Row + 1, Tower),
    NewRowList = set_nth(Glass + 1, RowList, Value),
    set_nth(Row + 1, Tower, NewRowList).

set_nth(1, [_|T], X) -> [X|T];
set_nth(N, [H|T], X) -> [H|set_nth(N-1, T, X)].