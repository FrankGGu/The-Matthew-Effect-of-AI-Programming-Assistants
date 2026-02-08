-module(max_points_from_grid_queries).
-export([maxPoints/2]).

maxPoints(Grid, Queries) ->
    SortedQueries = lists:sort(fun({_, A}, {_, B}) -> A < B end, Queries),
    Points = lists:foldl(fun(Query, Acc) -> 
        {Point, _} = Query,
        [Row | _] = Grid,
        MaxRow = length(Row),
        MaxCol = length(Grid),
        {_, MaxVal} = lists:foldl(fun(RowIndex, {MaxR, MaxC}) ->
            RowData = lists:nth(RowIndex + 1, Grid),
            lists:foldl(fun(ColIndex, {R, C}) ->
                if
                    RowIndex + ColIndex >= Point ->
                        {R, C};
                    true ->
                        {RowIndex, ColIndex}
                end
            end, {MaxR, MaxC}, lists:seq(0, MaxCol - 1))
        end, {0, 0}, lists:seq(0, MaxRow - 1)),
        Acc ++ [{Query, MaxVal}]
    end, [], SortedQueries),
    lists:map(fun({{_, P}, V}) -> {P, V} end, Points).

main(_) ->
    ok.