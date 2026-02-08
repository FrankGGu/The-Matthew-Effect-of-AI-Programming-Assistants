-spec distinct_colors(balls :: [integer()]) -> integer().
distinct_colors(Balls) ->
    length(lists:usort(Balls)).