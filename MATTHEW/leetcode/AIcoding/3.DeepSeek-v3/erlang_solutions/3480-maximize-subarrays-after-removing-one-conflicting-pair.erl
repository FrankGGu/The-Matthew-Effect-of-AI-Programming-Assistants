-spec maximize_subarrays(Nums :: [integer()]) -> integer().
maximize_subarrays(Nums) ->
    case Nums of
        [] -> 0;
        [_] -> 1;
        _ ->
            Conflicts = find_conflicts(Nums),
            case Conflicts of
                [] -> count_subarrays(Nums);
                _ ->
                    Max = lists:max([count_subarrays(remove_conflict(Nums, C)) || C <- Conflicts]),
                    Max
            end
    end.

find_conflicts(Nums) ->
    find_conflicts(Nums, [], 0).

find_conflicts([_], Acc, _) -> Acc;
find_conflicts([A, B | Rest], Acc, Index) ->
    case A > B of
        true -> find_conflicts([B | Rest], [Index | Acc], Index + 1);
        false -> find_conflicts([B | Rest], Acc, Index + 1)
    end.

remove_conflict(Nums, Index) ->
    lists:sublist(Nums, Index) ++ lists:nthtail(Index + 1, Nums).

count_subarrays(Nums) ->
    count_subarrays(Nums, 0, 1).

count_subarrays([], Total, _) -> Total;
count_subarrays([_], Total, Len) -> Total + Len;
count_subarrays([A, B | Rest], Total, Len) ->
    case A =< B of
        true -> count_subarrays([B | Rest], Total, Len + 1);
        false -> count_subarrays([B | Rest], Total + Len * (Len + 1) div 2, 1)
    end.