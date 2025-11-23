-module(num_matrix).
-export([init/1, sum_region/4]).

-record(matrix, {sums}).

init(Matrix) ->
    case Matrix of
        [] -> #matrix{sums = []};
        _ ->
            Rows = length(Matrix),
            Cols = length(hd(Matrix)),
            Sums = lists:foldl(fun(Row, Acc) ->
                lists:foldl(fun(Col, RowAcc) ->
                    case {Row, Col} of
                        {0, 0} -> [[lists:nth(Col + 1, lists:nth(Row + 1, Matrix))]];
                        {0, _} -> 
                            [Prev | Rest] = RowAcc,
                            [[Prev + lists:nth(Col + 1, lists:nth(Row + 1, Matrix)) | Rest]];
                        {_, 0} -> 
                            [PrevRow | _] = Acc,
                            [[lists:nth(1, PrevRow) + lists:nth(Col + 1, lists:nth(Row + 1, Matrix))] | Acc];
                        _ ->
                            [PrevRow | RestRows] = Acc,
                            [Prev | Rest] = PrevRow,
                            [[Prev + lists:nth(Col + 1, lists:nth(Row + 1, Matrix)) - lists:nth(1, Rest) + lists:nth(1, RestRows) | Rest] | RestRows]
                    end
                end, [], lists:seq(0, Cols - 1))
            end, [], lists:seq(0, Rows - 1)),
            #matrix{sums = lists:reverse(Sums)}
    end.

sum_region(#matrix{sums = Sums}, Row1, Col1, Row2, Col2) ->
    case Sums of
        [] -> 0;
        _ ->
            A = if Row1 =:= 0 orelse Col1 =:= 0 -> 0;
                   true -> lists:nth(Col1, lists:nth(Row1, Sums))
                end,
            B = if Row1 =:= 0 -> 0;
                   true -> lists:nth(Col2 + 1, lists:nth(Row1, Sums))
                end,
            C = if Col1 =:= 0 -> 0;
                   true -> lists:nth(Col1, lists:nth(Row2 + 1, Sums))
                end,
            D = lists:nth(Col2 + 1, lists:nth(Row2 + 1, Sums)),
            D - B - C + A
    end.