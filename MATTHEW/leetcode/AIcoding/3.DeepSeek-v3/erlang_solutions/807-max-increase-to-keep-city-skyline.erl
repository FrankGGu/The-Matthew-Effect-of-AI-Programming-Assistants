-spec max_increase_keeping_skyline(Grid :: [[integer()]]) -> integer().
max_increase_keeping_skyline(Grid) ->
    RowMax = lists:map(fun lists:max/1, Grid),
    ColMax = lists:map(fun lists:max/1, transpose(Grid)),
    lists:sum([lists:min([lists:nth(J, RowMax), lists:nth(I, ColMax)]) - Val 
                || {Row, I} <- lists:zip(Grid, lists:seq(1, length(Grid))),
                   {Val, J} <- lists:zip(Row, lists:seq(1, length(Row)))])).

transpose([[]|_]) -> [];
transpose(M) ->
    [lists:map(fun hd/1, M) | transpose(lists:map(fun tl/1, M))].