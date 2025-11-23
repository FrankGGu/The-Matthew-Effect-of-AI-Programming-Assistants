-module(solution).
-export([max_score/1]).

max_score(Grid) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),
    Max = 0,
    lists:foldl(fun(Row, Acc) ->
                        lists:foldl(fun(Col, Acc2) ->
                                            Val = lists:nth(Row+1, Grid) -- [lists:nth(Col+1, lists:nth(Row+1, Grid))],
                                            case Val of
                                                [] -> Acc2;
                                                _ -> 
                                                    Sum = lists:sum(Val),
                                                    if Sum > Acc2 -> Sum;
                                                       true -> Acc2
                                                    end
                                            end
                                end, Acc, lists:seq(0, Cols-1))
                end, Max, lists:seq(0, Rows-1)).

lists:nth(Index, List) ->
    lists:nth(Index + 1, List).