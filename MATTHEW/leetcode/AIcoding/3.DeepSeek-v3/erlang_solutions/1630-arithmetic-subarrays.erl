-spec check_arithmetic_subarrays(Nums :: [integer()], L :: [integer()], R :: [integer()]) -> [boolean()].
check_arithmetic_subarrays(Nums, L, R) ->
    lists:map(fun({Left, Right}) ->
        Subarray = lists:sublist(Nums, Left + 1, Right - Left + 1),
        Sorted = lists:sort(Subarray),
        check_arithmetic(Sorted)
    end, lists:zip(L, R)).

check_arithmetic([_]) -> true;
check_arithmetic([X, Y | Rest]) ->
    Diff = Y - X,
    check_arithmetic([Y | Rest], Diff).

check_arithmetic([_], _Diff) -> true;
check_arithmetic([X, Y | Rest], Diff) ->
    case Y - X of
        Diff -> check_arithmetic([Y | Rest], Diff);
        _ -> false
    end.