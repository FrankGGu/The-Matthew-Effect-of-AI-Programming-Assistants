-spec pivot_index(Nums :: [integer()]) -> integer().
pivot_index(Nums) ->
    TotalSum = lists:sum(Nums),
    pivot_index(Nums, 0, 0, TotalSum).

pivot_index([], _Index, _LeftSum, _TotalSum) -> -1;
pivot_index([H|T], Index, LeftSum, TotalSum) ->
    case LeftSum =:= TotalSum - LeftSum - H of
        true -> Index;
        false -> pivot_index(T, Index + 1, LeftSum + H, TotalSum)
    end.