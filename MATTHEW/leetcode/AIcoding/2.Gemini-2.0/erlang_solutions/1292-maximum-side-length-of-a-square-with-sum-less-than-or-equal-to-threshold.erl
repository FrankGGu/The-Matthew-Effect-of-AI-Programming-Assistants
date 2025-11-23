-module(max_side_length).
-export([maxSideLength/2]).

maxSideLength(Mat, Threshold) ->
    Rows = length(Mat),
    Cols = length(hd(Mat)),
    PrefixSum = generate_prefix_sum(Mat, Rows, Cols),
    max_side_length_helper(PrefixSum, Rows, Cols, Threshold, 0, min(Rows, Cols)).

generate_prefix_sum(Mat, Rows, Cols) ->
    lists:foldl(
        fun(RowIndex, Acc) ->
            lists:foldl(
                fun(ColIndex, Acc2) ->
                    Val = lists:nth(RowIndex, lists:nth(ColIndex, Mat)),
                    PrevRow = case RowIndex > 1 of
                                  true -> lists:nth(RowIndex - 1, lists:nth(ColIndex, Acc2));
                                  false -> 0
                              end,
                    PrevCol = case ColIndex > 1 of
                                  true -> lists:nth(RowIndex, lists:nth(ColIndex - 1, Acc2));
                                  false -> 0
                              end,
                    PrevDiag = case RowIndex > 1 andalso ColIndex > 1 of
                                   true -> lists:nth(RowIndex - 1, lists:nth(ColIndex - 1, Acc2));
                                   false -> 0
                               end,
                    Val + PrevRow + PrevCol - PrevDiag
                end,
                Acc,
                lists:seq(1, Cols)
            )
        end,
        generate_empty_matrix(Rows, Cols),
        lists:seq(1, Rows)
    ).

generate_empty_matrix(Rows, Cols) ->
    lists:map(fun(_) -> lists:duplicate(Cols, 0) end, lists:seq(1, Rows)).

max_side_length_helper(PrefixSum, Rows, Cols, Threshold, Left, Right) ->
    if Left > Right then
        Left - 1
    else
        Mid = (Left + Right) div 2,
        case check_side_length(PrefixSum, Rows, Cols, Threshold, Mid) of
            true ->
                max_side_length_helper(PrefixSum, Rows, Cols, Threshold, Mid + 1, Right);
            false ->
                max_side_length_helper(PrefixSum, Rows, Cols, Threshold, Left, Mid - 1)
        end
    end.

check_side_length(PrefixSum, Rows, Cols, Threshold, Length) ->
    lists:any(
        fun(Row) ->
            lists:any(
                fun(Col) ->
                    case Row + Length > Rows + 1 orelse Col + Length > Cols + 1 of
                        true ->
                            false;
                        false ->
                            Sum = calculate_sum(PrefixSum, Row, Col, Length),
                            Sum =< Threshold
                    end
                end,
                lists:seq(1, Cols)
            )
        end,
        lists:seq(1, Rows)
    ).

calculate_sum(PrefixSum, Row, Col, Length) ->
    Row1 = Row - 1,
    Col1 = Col - 1,
    Row2 = Row + Length - 1,
    Col2 = Col + Length - 1,

    Val22 = lists:nth(Row2, lists:nth(Col2, PrefixSum)),

    Val11 = case Row1 > 0 andalso Col1 > 0 of
                true -> lists:nth(Row1, lists:nth(Col1, PrefixSum));
                false -> 0
            end,

    Val12 = case Row1 > 0 of
                true -> lists:nth(Row1, lists:nth(Col2, PrefixSum));
                false -> 0
            end,

    Val21 = case Col1 > 0 of
                true -> lists:nth(Row2, lists:nth(Col1, PrefixSum));
                false -> 0
            end,

    Val22 - Val12 - Val21 + Val11.