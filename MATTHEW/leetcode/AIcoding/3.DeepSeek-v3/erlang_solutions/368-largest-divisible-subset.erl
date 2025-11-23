-spec largest_divisible_subset(Nums :: [integer()]) -> [integer()].
largest_divisible_subset(Nums) ->
    case Nums of
        [] -> [];
        _ ->
            Sorted = lists:sort(fun(A, B) -> A =< B end, Nums),
            DP = array:new([{size, length(Sorted)}, {default, 1}]),
            Parent = array:new([{size, length(Sorted)}, {default, -1}]),
            {DP1, Parent1} = build_dp(Sorted, DP, Parent, 0, 1),
            MaxIdx = find_max_index(DP1, 0, 0),
            construct_subset(Sorted, Parent1, MaxIdx, [])
    end.

build_dp([], DP, Parent, _, _) -> {DP, Parent};
build_dp([H | T], DP, Parent, I, J) ->
    case J < array:size(DP) of
        true ->
            case lists:nth(J, T) rem H =:= 0 of
                true ->
                    case array:get(I, DP) + 1 > array:get(J, DP) of
                        true ->
                            NewDP = array:set(J, array:get(I, DP) + 1, DP),
                            NewParent = array:set(J, I, Parent),
                            build_dp([H | T], NewDP, NewParent, I, J + 1);
                        false ->
                            build_dp([H | T], DP, Parent, I, J + 1)
                    end;
                false ->
                    build_dp([H | T], DP, Parent, I, J + 1)
            end;
        false ->
            build_dp(T, DP, Parent, I + 1, I + 2)
    end.

find_max_index(DP, I, MaxIdx) ->
    case I < array:size(DP) of
        true ->
            case array:get(I, DP) > array:get(MaxIdx, DP) of
                true -> find_max_index(DP, I + 1, I);
                false -> find_max_index(DP, I + 1, MaxIdx)
            end;
        false ->
            MaxIdx
    end.

construct_subset(_, Parent, -1, Subset) -> Subset;
construct_subset(Nums, Parent, I, Subset) ->
    construct_subset(Nums, Parent, array:get(I, Parent), [lists:nth(I + 1, Nums) | Subset]).