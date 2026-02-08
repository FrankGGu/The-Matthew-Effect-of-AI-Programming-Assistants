-module(maximum_difference_score).
-export([max_difference_score/1]).

max_difference_score(Grid) ->
    {Rows, Cols} = grid_size(Grid),
    dp(Grid, Rows, Cols).

grid_size(Grid) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),
    {Rows, Cols}.

dp(Grid, Rows, Cols) ->
    memo(Grid, Rows, Cols, lists:duplicate(Rows, lists:duplicate(Cols, -1))).

memo(Grid, Rows, Cols, Memo) ->
    memo(Grid, Rows, Cols, 0, 0, Memo).

memo(Grid, Rows, Cols, Row, Col, Memo) ->
    case get_memo(Row, Col, Memo) of
        -1 ->
            case {Row, Col} of
                {Rows - 1, Cols - 1} ->
                    Element = lists:nth(Row + 1, Grid),
                    Value = lists:nth(Col + 1, Element),
                    set_memo(Row, Col, Value, Memo);
                _ ->
                    Element = lists:nth(Row + 1, Grid),
                    Value = lists:nth(Col + 1, Element),
                    RightScore = case Col + 1 < Cols of
                                     true ->
                                         RightMemo = memo(Grid, Rows, Cols, Row, Col + 1, Memo),
                                         Value - get_memo(Row, Col + 1, RightMemo);
                                     false ->
                                         -10000000000000
                                 end,
                    DownScore = case Row + 1 < Rows of
                                    true ->
                                        DownMemo = memo(Grid, Rows, Cols, Row + 1, Col, Memo),
                                        Value - get_memo(Row + 1, Col, DownMemo);
                                    false ->
                                        -10000000000000
                                end,
                    MaxScore = max(RightScore, DownScore),
                    set_memo(Row, Col, MaxScore, Memo)
            end;
        Score ->
            Memo
    end.

get_memo(Row, Col, Memo) ->
    lists:nth(Row + 1, lists:nth(Col + 1, transpose(Memo))).

set_memo(Row, Col, Value, Memo) ->
    NewMemo = update_nested(Row, Col, Value, Memo),
    Value.

update_nested(Row, Col, Value, Matrix) ->
    lists:map(fun(RowIndex, RowElement) ->
                      case RowIndex of
                          Row ->
                              lists:map(fun(ColIndex, ColElement) ->
                                                case ColIndex of
                                                    Col ->
                                                        Value;
                                                    _ ->
                                                        ColElement
                                                end
                                        end, lists:seq(0, length(RowElement) - 1), RowElement);
                          _ ->
                              RowElement
                      end
              end, lists:seq(0, length(Matrix) - 1), Matrix).

transpose(Matrix) ->
    case Matrix of
        [] -> [];
        _ ->
            lists:map(fun(I) ->
                              [lists:nth(I + 1, Row) || Row <- Matrix]
                      end, lists:seq(0, length(hd(Matrix)) - 1))
    end.