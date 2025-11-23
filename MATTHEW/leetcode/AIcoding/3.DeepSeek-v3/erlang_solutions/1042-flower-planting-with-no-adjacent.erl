-spec garden_no_adj(N :: integer(), Paths :: [[integer()]]) -> [integer()].
garden_no_adj(N, Paths) ->
    Adj = lists:foldl(fun([X, Y], Acc) ->
                          dict:append(X, Y, dict:append(Y, X, Acc))
                      end, dict:new(), Paths),
    Colors = array:new(N, {default, 1}),
    lists:foldl(fun(Garden, Cols) ->
                    Used = lists:foldl(fun(Neighbor, UsedColors) ->
                                           case array:get(Neighbor - 1, Cols) of
                                               undefined -> UsedColors;
                                               C -> [C | UsedColors]
                                           end
                                       end, [], dict:fetch(Garden, Adj)),
                    Available = lists:seq(1, 4) -- lists:usort(Used),
                    array:set(Garden - 1, hd(Available), Cols)
                end, Colors, lists:seq(1, N)),
    array:to_list(Colors).