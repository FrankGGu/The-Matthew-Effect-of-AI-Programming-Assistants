-spec decorate_record(Tree :: #{} | null) -> list().
decorate_record(null) -> [];
decorate_record(Tree) -> decorate_record([Tree], []).

decorate_record([], Acc) -> lists:reverse(Acc);
decorate_record([null | Rest], Acc) -> decorate_record(Rest, Acc);
decorate_record([#{left := Left, right := Right, val := Val} | Rest], Acc) ->
    decorate_record(Rest ++ [Left, Right], [Val | Acc]).