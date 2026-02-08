select_first_three_rows() ->
    Results = ets:match(YourTableName, {'$_', '$_', '$_'}),
    lists:take(3, Results).