-spec row_and_maximum_ones(Mat :: [[integer()]]) -> [integer()].
row_and_maximum_ones(Mat) ->
    Counts = lists:map(fun(Row) -> lists:sum(Row) end, Mat),
    Max = lists:max(Counts),
    Index = index_of(Max, Counts, 0),
    [Index, Max].

index_of(Value, [Value | _], Index) -> Index;
index_of(Value, [_ | Rest], Index) -> index_of(Value, Rest, Index + 1).