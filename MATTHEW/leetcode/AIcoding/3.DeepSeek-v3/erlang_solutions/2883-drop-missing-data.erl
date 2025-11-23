-spec drop_missing_data(DataFrame :: pid()) -> pid().
drop_missing_data(DataFrame) ->
    dataframe:drop_nulls(DataFrame).