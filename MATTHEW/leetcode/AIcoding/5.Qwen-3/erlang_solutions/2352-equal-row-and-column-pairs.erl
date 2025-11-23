-module(equ_row_col_pairs).
-export([equal_pairs/1]).

equal_pairs(Grid) ->
    Rows = Grid,
    Cols = get_columns(Grid),
    count_matches(Rows, Cols).

get_columns(Grid) ->
    lists:foldl(fun(_Row, Acc) -> 
                    lists:seq(1, length(Grid)) 
                end, [], Grid),
    get_columns(Grid, []).

get_columns([], Acc) ->
    Acc;
get_columns([Row | Rest], Acc) ->
    Column = lists:map(fun(I) -> lists:nth(I, Row) end, lists:seq(1, length(Row))),
    get_columns(Rest, [Column | Acc]).

count_matches(Rows, Cols) ->
    count_matches(Rows, Cols, 0).

count_matches([], _, Count) ->
    Count;
count_matches([Row | RestRows], Cols, Count) ->
    case lists:member(Row, Cols) of
        true -> count_matches(RestRows, Cols, Count + 1);
        false -> count_matches(RestRows, Cols, Count)
    end.