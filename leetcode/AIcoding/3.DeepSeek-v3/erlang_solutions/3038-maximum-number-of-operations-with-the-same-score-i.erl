-spec max_operations(nums :: [integer()]) -> integer().
max_operations(Nums) ->
    case Nums of
        [A, B | Rest] ->
            Sum = A + B,
            max_operations(Rest, Sum, 1);
        _ ->
            0
    end.

max_operations([A, B | Rest], Sum, Count) ->
    case A + B of
        Sum ->
            max_operations(Rest, Sum, Count + 1);
        _ ->
            Count
    end;
max_operations(_, _, Count) ->
    Count.