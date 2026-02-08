-spec max_equal_rows_after_flips(Matrix :: [[integer()]]) -> integer().
max_equal_rows_after_flips(Matrix) ->
    Counts = lists:foldl(fun(Row, Acc) ->
        Pattern1 = Row,
        Pattern2 = lists:map(fun(X) -> 1 - X end, Row),
        Key = lists:min([Pattern1, Pattern2]),
        maps:update_with(Key, fun(V) -> V + 1 end, 1, Acc)
    end, #{}, Matrix),
    case maps:values(Counts) of
        [] -> 0;
        Values -> lists:max(Values)
    end.