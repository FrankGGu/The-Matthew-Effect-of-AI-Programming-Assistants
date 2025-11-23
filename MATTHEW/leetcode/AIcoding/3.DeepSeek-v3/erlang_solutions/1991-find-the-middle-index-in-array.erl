-spec find_middle_index(Nums :: [integer()]) -> integer().
find_middle_index(Nums) ->
    TotalSum = lists:sum(Nums),
    find_middle_index(Nums, 0, 0, TotalSum).

find_middle_index([], _Index, _LeftSum, _TotalSum) -> -1;
find_middle_index([X | Rest], Index, LeftSum, TotalSum) ->
    case LeftSum =:= TotalSum - LeftSum - X of
        true -> Index;
        false -> find_middle_index(Rest, Index + 1, LeftSum + X, TotalSum)
    end.