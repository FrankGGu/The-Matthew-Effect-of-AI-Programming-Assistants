-spec smallest_string([char()]) -> [char()].
smallest_string(S) ->
    smallest_string(S, []).

-spec smallest_string([char()], [char()]) -> [char()].
smallest_string([], Acc) ->
    lists:reverse(Acc);
smallest_string([H | T], []) ->
    smallest_string(T, [H]);
smallest_string([H | T], [A | _] = Acc) when H < A ->
    case T of
        [] -> [H | Acc];
        _ -> smallest_string(T, [H])
    end;
smallest_string([H | T], Acc) ->
    smallest_string(T, [H | Acc]).