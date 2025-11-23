-spec display_first_three_rows(DataFrame :: term()) -> term().
display_first_three_rows(DataFrame) ->
    case DataFrame of
        [] -> [];
        [H|T] when length([H|T]) >= 3 -> lists:sublist([H|T], 3);
        _ -> DataFrame
    end.