-spec maximum_unique_subarray(Nums :: [integer()]) -> integer().
maximum_unique_subarray(Nums) ->
    maximum_unique_subarray(Nums, #{}, 0, 0, 0).

maximum_unique_subarray([], _Map, _Left, _CurrentSum, MaxSum) ->
    MaxSum;
maximum_unique_subarray([Num | Rest], Map, Left, CurrentSum, MaxSum) ->
    case maps:get(Num, Map, -1) of
        -1 ->
            NewCurrentSum = CurrentSum + Num,
            NewMap = maps:put(Num, Left + 1, Map),
            maximum_unique_subarray(Rest, NewMap, Left + 1, NewCurrentSum, max(NewCurrentSum, MaxSum));
        Pos when Pos >= Left ->
            NewCurrentSum = CurrentSum + Num,
            NewLeft = Pos + 1,
            NewMap = maps:put(Num, Left + 1, Map),
            maximum_unique_subarray(Rest, NewMap, Left + 1, NewCurrentSum, max(NewCurrentSum, MaxSum));
        _ ->
            NewCurrentSum = CurrentSum + Num,
            NewMap = maps:put(Num, Left + 1, Map),
            maximum_unique_subarray(Rest, NewMap, Left + 1, NewCurrentSum, max(NewCurrentSum, MaxSum))
    end.