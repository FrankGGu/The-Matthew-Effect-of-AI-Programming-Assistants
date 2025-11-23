-spec max_sequence_value(Nums :: [integer()]) -> integer().
max_sequence_value(Nums) ->
    case Nums of
        [] -> 0;
        _ ->
            lists:max([0 | max_subarray(Nums)])
    end.

max_subarray([H | T]) ->
    max_subarray(T, H, H).

max_subarray([], Current, Max) ->
    [Max];
max_subarray([H | T], Current, Max) ->
    NewCurrent = max(H, Current + H),
    NewMax = max(NewCurrent, Max),
    max_subarray(T, NewCurrent, NewMax).