-spec diagonal_order(Nums :: [[integer()]]) -> [integer()].
diagonal_order(Nums) ->
    Map = lists:foldl(fun(Row, Acc) ->
        lists:foldl(fun({Elem, Col}, Acc1) ->
            Key = Row + Col,
            case maps:find(Key, Acc1) of
                {ok, List} -> maps:put(Key, [Elem | List], Acc1);
                error -> maps:put(Key, [Elem], Acc1)
            end
        end, Acc, lists:zip(Row, lists:seq(0, length(Row) - 1)))
    end, maps:new(), lists:zipwith(fun(Row, Index) -> Row end, Nums, lists:seq(0, length(Nums) - 1))),
    SortedKeys = lists:sort(maps:keys(Map)),
    lists:foldl(fun(Key, Acc) -> Acc ++ maps:get(Key, Map) end, [], SortedKeys).