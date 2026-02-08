-module(solve).
-export([count_servers/1]).

count_servers(Servers) ->
    Rows = length(Servers),
    Cols = length(hd(Servers)),
    RowCount = array:new(Rows, {default, 0}),
    ColCount = array:new(Cols, {default, 0}),
    lists:foreach(fun({Row, Col, Server}) -> 
        if Server == 1 -> 
            RowCount1 = array:set(Row, array:get(Row, RowCount) + 1, RowCount),
            ColCount1 = array:set(Col, array:get(Col, ColCount) + 1, ColCount),
            RowCount2 = RowCount1,
            ColCount2 = ColCount1;
        true -> 
            RowCount2 = RowCount,
            ColCount2 = ColCount
        end
    end, lists:foldl(fun(Row, Acc) -> 
        lists:foldl(fun(Col, Acc2) -> 
            case lists:nth(Col+1, lists:nth(Row+1, Servers)) of
                1 -> [{Row, Col, 1} | Acc2];
                _ -> Acc2
            end
        end, Acc, lists:seq(0, Cols-1))
    end, [], lists:seq(0, Rows-1))),
    Count = lists:foldl(fun(Row, Acc) -> 
        lists:foldl(fun(Col, Acc2) -> 
            case lists:nth(Col+1, lists:nth(Row+1, Servers)) of
                1 -> 
                    if array:get(Row, RowCount) > 1 orelse array:get(Col, ColCount) > 1 -> Acc2 + 1;
                       true -> Acc2
                    end;
                _ -> Acc2
            end
        end, Acc, lists:seq(0, Cols-1))
    end, 0, lists:seq(0, Rows-1)),
    Count.