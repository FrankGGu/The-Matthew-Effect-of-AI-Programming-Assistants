-module(drop_duplicate_rows).
-export([drop_duplicates/1]).

drop_duplicates(Data) ->
    drop_duplicates(Data, []).

drop_duplicates([], Acc) ->
    lists:reverse(Acc);
drop_duplicates([Row | Rest], Acc) ->
    case lists:member(Row, Acc) of
        true -> drop_duplicates(Rest, Acc);
        false -> drop_duplicates(Rest, [Row | Acc])
    end.