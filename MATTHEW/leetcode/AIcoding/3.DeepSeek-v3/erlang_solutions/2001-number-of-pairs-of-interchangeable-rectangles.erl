-spec interchangeable_rectangles(Rectangles :: [[integer()]]) -> integer().
interchangeable_rectangles(Rectangles) ->
    Ratios = lists:map(fun([W, H]) -> W / H end, Rectangles),
    Counts = lists:foldl(fun(Ratio, Acc) -> 
                            maps:update_with(Ratio, fun(V) -> V + 1 end, 1, Acc)
                         end, #{}, Ratios),
    lists:foldl(fun(V, Sum) -> Sum + V * (V - 1) div 2 end, 0, maps:values(Counts)).