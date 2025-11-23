-spec check_possibility(Nums :: [integer()]) -> boolean().
check_possibility(Nums) ->
    check_possibility(Nums, 0, 0).

check_possibility([_], Count, _) when Count =< 1 ->
    true;
check_possibility([_], Count, _) ->
    false;
check_possibility([A, B | Rest], Count, Prev) when A =< B ->
    check_possibility([B | Rest], Count, A);
check_possibility([A, B | Rest], Count, Prev) when Count >= 1 ->
    false;
check_possibility([A, B | Rest], Count, Prev) ->
    case Rest of
        [] ->
            true;
        [C | _] when A =< C ->
            check_possibility([A, C | Rest], Count + 1, Prev);
        [C | _] when B >= Prev ->
            check_possibility([B, B | Rest], Count + 1, Prev);
        _ ->
            false
    end.