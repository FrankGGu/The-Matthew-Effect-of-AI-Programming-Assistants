-spec ways_to_split_array(Nums :: [integer()]) -> integer().
ways_to_split_array(Nums) ->
    Total = lists:sum(Nums),
    ways_to_split_array(Nums, Total, 0, 0, 0).

ways_to_split_array([], _, _, _, Count) -> Count;
ways_to_split_array([H | T], Total, LeftSum, Index, Count) ->
    NewLeftSum = LeftSum + H,
    RightSum = Total - NewLeftSum,
    if
        NewLeftSum >= RightSum -> NewCount = Count + 1;
        true -> NewCount = Count
    end,
    ways_to_split_array(T, Total, NewLeftSum, Index + 1, NewCount).