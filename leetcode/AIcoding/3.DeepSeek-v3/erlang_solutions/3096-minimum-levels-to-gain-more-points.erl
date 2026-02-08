-spec minimum_levels(Binary :: [integer()]) -> integer().
minimum_levels(Binary) ->
    Total = lists:sum(Binary),
    minimum_levels(Binary, 0, 0, Total, length(Binary)).

minimum_levels(_, _, _, _, 1) -> -1;
minimum_levels([H | T], Sum1, Sum2, Total, Len) ->
    NewSum1 = Sum1 + H,
    NewSum2 = Total - NewSum1,
    if
        NewSum1 > NewSum2 -> Len - length(T);
        true -> minimum_levels(T, NewSum1, NewSum2, Total, Len)
    end.