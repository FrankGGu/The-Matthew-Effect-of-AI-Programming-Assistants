-spec maximum_difference(Nums :: [integer()]) -> integer().
maximum_difference(Nums) ->
    maximum_difference(Nums, 0, -1, 100000).

maximum_difference([], MaxDiff, _, _) ->
    case MaxDiff of
        0 -> -1;
        _ -> MaxDiff
    end;
maximum_difference([H | T], MaxDiff, Min, _) when H < Min ->
    maximum_difference(T, MaxDiff, H, H);
maximum_difference([H | T], MaxDiff, Min, Prev) when H > Prev ->
    Diff = H - Min,
    NewMaxDiff = max(MaxDiff, Diff),
    maximum_difference(T, NewMaxDiff, Min, H);
maximum_difference([H | T], MaxDiff, Min, _) ->
    maximum_difference(T, MaxDiff, Min, H).