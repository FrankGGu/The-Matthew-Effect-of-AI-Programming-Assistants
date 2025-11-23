-spec min_changes(Nums :: [integer()]) -> integer().
min_changes(Nums) ->
    case Nums of
        [] -> 0;
        [_] -> 0;
        [_, _] -> 0;
        _ ->
            Diffs = lists:zipwith(fun(X, Y) -> Y - X end, Nums, tl(Nums)),
            UniqueDiffs = lists:usort(Diffs),
            case length(UniqueDiffs) of
                1 -> 0;
                2 -> 
                    [D1, D2] = UniqueDiffs,
                    case (D1 + D2) rem 2 of
                        0 -> 
                            Target = (D1 + D2) div 2,
                            Count1 = count_changes(Diffs, Target, 0),
                            Count2 = count_changes(Diffs, D1, 0),
                            Count3 = count_changes(Diffs, D2, 0),
                            min(Count1, min(Count2, Count3));
                        _ -> 
                            Count1 = count_changes(Diffs, D1, 0),
                            Count2 = count_changes(Diffs, D2, 0),
                            min(Count1, Count2)
                    end;
                _ -> 
                    MinDiff = lists:min(UniqueDiffs),
                    MaxDiff = lists:max(UniqueDiffs),
                    Target = (MinDiff + MaxDiff) div 2,
                    Count1 = count_changes(Diffs, Target, 0),
                    Count2 = count_changes(Diffs, Target + 1, 0),
                    Count3 = count_changes(Diffs, Target - 1, 0),
                    min(Count1, min(Count2, Count3))
            end
    end.

count_changes([], _, Count) -> Count;
count_changes([Diff | Rest], Target, Count) ->
    if 
        Diff =:= Target -> count_changes(Rest, Target, Count);
        true -> count_changes(Rest, Target, Count + 1)
    end.