-spec flip_and_invert_image(Image :: [[integer()]]) -> [[integer()]].
flip_and_invert_image(Image) ->
    lists:map(fun(Row) ->
                  ReversedRow = lists:reverse(Row),
                  lists:map(fun(X) -> 1 - X end, ReversedRow)
              end, Image).