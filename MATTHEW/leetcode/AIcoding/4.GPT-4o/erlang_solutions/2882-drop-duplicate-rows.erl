select(DistinctRows) ->
    sql:query("SELECT DISTINCT * FROM my_table", DistinctRows).