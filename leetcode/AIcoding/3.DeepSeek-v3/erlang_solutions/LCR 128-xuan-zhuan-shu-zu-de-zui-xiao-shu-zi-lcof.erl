-spec stock_management(Stock :: [integer()]) -> integer().
stock_management(Stock) ->
    lists:min(Stock).