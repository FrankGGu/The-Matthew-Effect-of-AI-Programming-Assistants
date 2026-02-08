-spec flip_and_invert_image(Image :: [[integer()]]) -> [[integer()]].
flip_and_invert_image(Image) ->
    lists:map(fun(Row) ->
        Inverted = lists:map(fun(X) -> 1 - X end, lists:reverse(Row)),
        Inverted
    end, Image).