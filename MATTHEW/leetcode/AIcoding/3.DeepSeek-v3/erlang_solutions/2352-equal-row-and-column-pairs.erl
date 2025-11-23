-spec equal_pairs(Grid :: [[integer()]]) -> integer().
equal_pairs(Grid) ->
    Rows = lists:map(fun(Row) -> list_to_tuple(Row) end, Grid),
    Cols = lists:map(fun(I) -> 
                          Col = lists:map(fun(Row) -> lists:nth(I, Row) end, Grid),
                          list_to_tuple(Col)
                      end, lists:seq(1, length(hd(Grid)))),
    RowCounts = count_elements(Rows),
    ColCounts = count_elements(Cols),
    lists:sum([maps:get(Key, RowCounts, 0) * maps:get(Key, ColCounts, 0) || Key <- maps:keys(RowCounts)]).

count_elements(List) ->
    lists:foldl(fun(Key, Acc) -> 
                    maps:update_with(Key, fun(V) -> V + 1 end, 1, Acc)
                end, maps:new(), List).