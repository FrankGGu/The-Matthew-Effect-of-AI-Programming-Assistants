-spec min_number_operations(Target :: [integer()]) -> integer().
min_number_operations(Target) ->
    min_number_operations_acc(Target, 0, 0).

min_number_operations_acc([], _Prev, Acc) ->
    Acc;
min_number_operations_acc([H|T], Prev, Acc) ->
    Diff = H - Prev,
    NewAcc = Acc + erlang:max(0, Diff),
    min_number_operations_acc(T, H, NewAcc).