-module(cherry_pickup_ii).
-export([max_cherries/1]).

max_cherries(Grid) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),
    Memo = ets:new(memo_table, [set, public, named_table]),
    Result = solve(0, 0, Cols - 1, Grid, Rows, Cols, Memo),
    ets:delete(Memo),
    Result.

solve(Row, _, _, _, Rows, _, _) when Row == Rows ->
    0;
solve(Row, Col1, Col2, Grid, Rows, Cols, Memo) ->
    Key = {Row, Col1, Col2},
    case ets:lookup(Memo, Key) of
        [{Key, Value}] ->
            Value;
        [] ->
            CurrentCherries =
                lists:nth(Col1 + 1, lists:nth(Row + 1, Grid)) +
                (case Col1 == Col2 of
                    true -> 0;
                    false -> lists:nth(Col2 + 1, lists:nth(Row + 1, Grid))
                end),

            MaxNextCherries = calculate_max_next_cherries(Row, Col1, Col2, Grid, Rows, Cols, Memo),

            TotalCherries = CurrentCherries + MaxNextCherries,
            ets:insert(Memo, {Key, TotalCherries}),
            TotalCherries
    end.

calculate_max_next_cherries(Row, Col1, Col2, Grid, Rows, Cols, Memo) ->
    NextRow = Row + 1,
    PossibleMoves = [-1, 0, 1],
    Max = 0,

    lists:foldl(fun(Move1, AccMax1) ->
        NextCol1 = Col1 + Move1,
        case (NextCol1 >= 0) and (NextCol1 < Cols) of
            true ->
                lists:foldl(fun(Move2, AccMax2) ->
                    NextCol2 = Col2 + Move2,
                    case (NextCol2 >= 0) and (NextCol2 < Cols) of
                        true ->
                            NextCherries = solve(NextRow, NextCol1, NextCol2, Grid, Rows, Cols, Memo),
                            max(AccMax2, NextCherries);
                        false ->
                            AccMax2
                    end
                end, AccMax1, PossibleMoves);
            false ->
                AccMax1
        end
    end, Max, PossibleMoves).