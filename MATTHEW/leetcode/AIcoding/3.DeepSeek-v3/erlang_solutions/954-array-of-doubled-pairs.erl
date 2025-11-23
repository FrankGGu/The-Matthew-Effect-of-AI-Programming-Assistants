-spec can_reorder_doubled(Arr :: [integer()]) -> boolean().
can_reorder_doubled(Arr) ->
    Counts = lists:foldl(fun(X, Acc) -> 
                            maps:update_with(X, fun(V) -> V + 1 end, 1, Acc)
                         end, #{}, Arr),
    Sorted = lists:sort(fun(A, B) -> abs(A) =< abs(B) end, Arr),
    check_pairs(Sorted, Counts).

check_pairs([], _) -> true;
check_pairs([X | Rest], Counts) ->
    case maps:get(X, Counts, 0) of
        0 -> check_pairs(Rest, Counts);
        _ ->
            case maps:get(2 * X, Counts, 0) of
                0 -> false;
                _ ->
                    NewCounts = maps:update(X, maps:get(X, Counts) - 1, Counts),
                    NewCounts1 = maps:update(2 * X, maps:get(2 * X, NewCounts) - 1, NewCounts),
                    check_pairs(Rest, NewCounts1)
            end
    end.