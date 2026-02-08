-module(solution).
-export([cherry_pickup/1]).

cherry_pickup(Grid) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),
    DP = maps:new(),
    cherry_pickup_helper(0, 0, Cols - 1, Grid, DP, Rows, Cols).

cherry_pickup_helper(Row, Col1, Col2, Grid, DP, Rows, Cols) ->
    case maps:find({Row, Col1, Col2}, DP) of
        {ok, Val} ->
            Val;
        error ->
            if
                Row =:= Rows - 1 ->
                    if
                        Col1 =:= Col2 -> lists:nth(Col1 + 1, lists:nth(Row + 1, Grid));
                        true -> lists:nth(Col1 + 1, lists:nth(Row + 1, Grid)) + lists:nth(Col2 + 1, lists:nth(Row + 1, Grid))
                    end;
                true ->
                    Max = -1,
                    NewMax = lists:foldl(fun(D1, Acc1) ->
                        NewCol1 = Col1 + D1,
                        if
                            NewCol1 >= 0, NewCol1 < Cols ->
                                lists:foldl(fun(D2, Acc2) ->
                                    NewCol2 = Col2 + D2,
                                    if
                                        NewCol2 >= 0, NewCol2 < Cols ->
                                            Current = if
                                                Col1 =:= Col2 -> lists:nth(Col1 + 1, lists:nth(Row + 1, Grid));
                                                true -> lists:nth(Col1 + 1, lists:nth(Row + 1, Grid)) + lists:nth(Col2 + 1, lists:nth(Row + 1, Grid))
                                            end,
                                            Next = cherry_pickup_helper(Row + 1, NewCol1, NewCol2, Grid, DP, Rows, Cols),
                                            max(Acc2, Current + Next);
                                        true ->
                                            Acc2
                                    end
                                end, Acc1, [-1, 0, 1]);
                            true ->
                                Acc1
                        end
                    end, Max, [-1, 0, 1]),
                    NewDP = maps:put({Row, Col1, Col2}, NewMax, DP),
                    NewMax
            end
    end.