-module(range_sum_query_2d).
-export([new/1, sum_region/5]).

new(Matrix) ->
    Rows = length(Matrix),
    Cols = case Rows > 0 of
               true -> length(hd(Matrix));
               false -> 0
           end,
    PrefixSum = lists:foldl(fun(Row, Acc) ->
                                  lists:foldl(fun(Col, Acc2) ->
                                                    Val = lists:nth(Col, lists:nth(Row, Matrix)),
                                                    case Row =:= 1 of
                                                        true ->
                                                            case Col =:= 1 of
                                                                true ->
                                                                    lists:append(Acc2, [[Val]]);
                                                                false ->
                                                                    Prev = lists:nth(Col - 1, lists:last(Acc2)),
                                                                    lists:append(Acc2, [[Prev + Val]])
                                                            end;
                                                        false ->
                                                            case Col =:= 1 of
                                                                true ->
                                                                    PrevRow = lists:nth(Row - 1, Acc),
                                                                    PrevRowVal = hd(PrevRow),
                                                                    lists:append(Acc2, [[PrevRowVal + Val]]);
                                                                false ->
                                                                    Prev = lists:nth(Col - 1, lists:last(Acc2)),
                                                                    PrevRow = lists:nth(Row - 1, Acc),
                                                                    PrevRowVal = lists:nth(Col, PrevRow),
                                                                    PrevPrevRowVal = lists:nth(Col - 1, PrevRow),
                                                                    lists:append(Acc2, [[Prev + PrevRowVal + Val - PrevPrevRowVal]])
                                                            end
                                                    end
                                               end, [], lists:seq(1, Cols))
                              end, [], lists:seq(1, Rows)),
    {PrefixSum, Rows, Cols}.

sum_region({PrefixSum, Rows, Cols}, Row1, Col1, Row2, Col2) ->
    Row1Index = Row1 + 1,
    Col1Index = Col1 + 1,
    Row2Index = Row2 + 1,
    Col2Index = Col2 + 1,

    FullSum = lists:nth(Col2Index, lists:nth(Row2Index, PrefixSum)),

    case Row1Index =:= 1 of
        true ->
            case Col1Index =:= 1 of
                true ->
                    FullSum;
                false ->
                    LeftSum = lists:nth(Col1Index - 1, lists:nth(Row2Index, PrefixSum)),
                    FullSum - LeftSum
            end;
        false ->
            case Col1Index =:= 1 of
                true ->
                    TopSum = lists:nth(Col2Index, lists:nth(Row1Index - 1, PrefixSum)),
                    FullSum - TopSum;
                false ->
                    LeftSum = lists:nth(Col1Index - 1, lists:nth(Row2Index, PrefixSum)),
                    TopSum = lists:nth(Col2Index, lists:nth(Row1Index - 1, PrefixSum)),
                    TopLeftSum = lists:nth(Col1Index - 1, lists:nth(Row1Index - 1, PrefixSum)),
                    FullSum - LeftSum - TopSum + TopLeftSum
            end
    end.