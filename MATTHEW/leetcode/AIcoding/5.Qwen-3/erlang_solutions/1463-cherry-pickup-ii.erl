-module(cherry_pickup_ii).
-export([cherry_pickup/1]).

cherry_pickup(Grid) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),
    dp(0, 0, 0, Grid, Rows, Cols, #{}).

dp(Row, Col1, Col2, Grid, Rows, Cols, Memo) ->
    Key = {Row, Col1, Col2},
    case maps:get(Key, Memo, undefined) of
        Val when is_integer(Val) -> Val;
        _ ->
            if
                Row >= Rows -> 0;
                true ->
                    Current = if
                        Col1 < 0 orelse Col1 >= Cols orelse Col2 < 0 orelse Col2 >= Cols -> -1;
                        true -> lists:nth(Row + 1, Grid) -- [Col1 + 1] ++ [Col2 + 1]
                    end,
                    if
                        Current == -1 -> -1;
                        true ->
                            NextRow = Row + 1,
                            Max = lists:max([
                                dp(NextRow, Col1 - 1, Col2 - 1, Grid, Rows, Cols, Memo),
                                dp(NextRow, Col1 - 1, Col2, Grid, Rows, Cols, Memo),
                                dp(NextRow, Col1 - 1, Col2 + 1, Grid, Rows, Cols, Memo),
                                dp(NextRow, Col1, Col2 - 1, Grid, Rows, Cols, Memo),
                                dp(NextRow, Col1, Col2, Grid, Rows, Cols, Memo),
                                dp(NextRow, Col1, Col2 + 1, Grid, Rows, Cols, Memo),
                                dp(NextRow, Col1 + 1, Col2 - 1, Grid, Rows, Cols, Memo),
                                dp(NextRow, Col1 + 1, Col2, Grid, Rows, Cols, Memo),
                                dp(NextRow, Col1 + 1, Col2 + 1, Grid, Rows, Cols, Memo)
                            ]),
                            if
                                Max == -1 -> -1;
                                true -> Current + Max
                            end
                    end
            end
    end.

lists:nth(Index, List) ->
    lists:nth(Index, List).

lists:--([A], [B]) ->
    A + B.