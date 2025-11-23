-spec minimum_total(Triangle :: [[integer()]]) -> integer().
minimum_total(Triangle) ->
    lists:foldl(fun(Row, Acc) -> 
                    lists:map(fun(X) -> X + min(Acc) end, Row)
                end, hd(Triangle), tl(Triangle)).

min(List) -> lists:min(List).
