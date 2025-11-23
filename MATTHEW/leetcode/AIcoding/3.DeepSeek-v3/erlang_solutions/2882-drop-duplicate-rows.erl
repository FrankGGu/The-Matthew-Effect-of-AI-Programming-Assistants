-spec drop_duplicate_rows(Data :: [[term()]]) -> [[term()]].
drop_duplicate_rows(Data) ->
    drop_duplicate_rows(Data, sets:new(), []).

drop_duplicate_rows([], _Seen, Acc) ->
    lists:reverse(Acc);
drop_duplicate_rows([Row | Rest], Seen, Acc) ->
    case sets:is_element(Row, Seen) of
        true -> drop_duplicate_rows(Rest, Seen, Acc);
        false -> drop_duplicate_rows(Rest, sets:add_element(Row, Seen), [Row | Acc])
    end.