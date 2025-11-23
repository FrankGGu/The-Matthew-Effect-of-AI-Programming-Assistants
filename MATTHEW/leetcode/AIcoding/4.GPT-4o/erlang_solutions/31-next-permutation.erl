-spec next_permutation(Nums :: list(integer())) -> list(integer()).
next_permutation(Nums) ->
    case find_decreasing_point(Nums) of
        {ok, I} -> 
            case find_swap_position(Nums, I) of
                {ok, J} -> 
                    NewNums = swap(Nums, I, J),
                    reverse(NewNums, I + 1);
                _ -> reverse(Nums, 0)
            end;
        _ -> lists:reverse(Nums)
    end.

find_decreasing_point([X, Y | Rest]) when X < Y -> {ok, 0};
find_decreasing_point([X, Y | Rest]) -> 
    case find_decreasing_point([Y | Rest]) of
        {ok, I} -> {ok, I + 1};
        _ -> error
    end;
find_decreasing_point(_) -> error.

find_swap_position(Nums, I) -> 
    find_swap_position(Nums, I, length(Nums) - 1).

find_swap_position(Nums, I, J) when lists:nth(I + 1, Nums) < lists:nth(J + 1, Nums) -> {ok, J};
find_swap_position(Nums, I, J) when J > I -> find_swap_position(Nums, I, J - 1);
find_swap_position(_, _, _) -> error.

swap(Nums, I, J) ->
    ElemI = lists:nth(I + 1, Nums),
    ElemJ = lists:nth(J + 1, Nums),
    lists:sublist(Nums, 1, I) ++ [ElemJ] ++ lists:sublist(Nums, I + 2, J - 1) ++ [ElemI] ++ lists:sublist(Nums, J + 1).

reverse(Nums, Start) ->
    lists:reverse(lists:sublist(Nums, Start + 1)).
