-module(solution).
-export([assign_elements_to_groups_with_constraints/3]).

assign_elements_to_groups_with_constraints(Nums, K, Constraints) ->
    N = length(Nums),
    Infinity = 1_000_000_000_000_000_000, % A sufficiently large number for infinity

    ForbiddenPairs = sets:new(),
    ForbiddenPairs1 = lists:foldl(
        fun([Idx1, Idx2, Val], AccForbiddenPairs) ->
            Num1 = lists:nth(Idx1 + 1, Nums),
            Num2 = lists:nth(Idx2 + 1, Nums),
            If abs(Num1 - Num2) =/= Val ->
                sets:add_element({min(Idx1, Idx2), max(Idx1, Id2)}, AccForbiddenPairs);
            Else ->
                AccForbiddenPairs
            End
        End,
        ForbiddenPairs,
        Constraints
    ),

    PrecomputedCosts = array:new({N, N}, {default, Infinity}),
    PrecomputedCosts1 = calculate_all_subarray_costs(Nums, N, ForbiddenPairs1, PrecomputedCosts, Infinity),

    DP = array:new({K + 1, N + 1}, {default, Infinity}),
    DP1 = array:set({0, 0}, 0, DP),

    DP_final = lists:foldl(
        fun(J, AccDP_J) ->
            lists:foldl(
                fun(I, AccDP_I) ->
                    lists:foldl(
                        fun(P, AccDP_P) ->
                            CostFromPrevGroup = array:get({J - 1, P}, AccDP_P),
                            If CostFromPrevGroup =/= Infinity ->
                                CurrentGroupCost = array:get({P, I - 1}, PrecomputedCosts1),
                                If CurrentGroupCost =/= Infinity ->
                                    NewCost = CostFromPrevGroup + CurrentGroupCost,
                                    OldMinCost = array:get({J, I}, AccDP_P),
                                    If NewCost < OldMinCost ->
                                        array:set({J, I}, NewCost, AccDP_P);
                                    Else ->
                                        AccDP_P
                                    End;
                                Else ->
                                    AccDP_P
                                End;
                            Else ->
                                AccDP_P
                            End
                        End,
                        AccDP_I,
                        lists:seq(0, I - 1)
                    )
                End,
                AccDP_J,
                lists:seq(1, N)
            )
        End,
        DP1,
        lists:seq(1, K)
    ),

    array:get({K, N}, DP_final).

calculate_all_subarray_costs(Nums, N, ForbiddenPairs, PrecomputedCosts, Infinity) ->
    lists:foldl(
        fun(P, AccPrecomputedCosts_P) ->
            lists:foldl(
                fun(I, AccPrecomputedCosts_I) ->
                    SubArrayElements = lists:sublist(Nums, P + 1, I - P + 1),

                    IsValidGroup = check_forbidden_pairs(P, I, ForbiddenPairs),

                    If IsValidGroup ->
                        SortedSubArray = lists:sort(SubArrayElements),
                        Len = length(SortedSubArray),
                        CurrentCost = calculate_group_cost_optimized(SortedSubArray, Len),
                        array:set({P, I}, CurrentCost, AccPrecomputedCosts_I);
                    Else ->
                        array:set({P, I}, Infinity, AccPrecomputedCosts_I)
                    End
                End,
                AccPrecomputedCosts_P,
                lists:seq(P, N - 1)
            )
        End,
        PrecomputedCosts,
        lists:seq(0, N - 1)
    ).

check_forbidden_pairs(P, I, ForbiddenPairs) ->
    lists:foldl(
        fun(X, AccIsValid) ->
            If AccIsValid ->
                lists:foldl(
                    fun(Y, AccIsValid_Y) ->
                        If AccIsValid_Y andalso sets:is_element({X, Y}, ForbiddenPairs) ->
                            false;
                        Else ->
                            AccIsValid_Y
                        End
                    End,
                    AccIsValid,
                    lists:seq(X + 1, I)
                );
            Else ->
                false
            End
        End,
        true,
        lists:seq(P, I)
    ).

calculate_group_cost_optimized(SortedSubArray, Len) ->
    calculate_group_cost_optimized_acc(SortedSubArray, Len, 0, 0).

calculate_group_cost_optimized_acc([], _Len, _Idx, AccCost) -> AccCost;
calculate_group_cost_optimized_acc([H|T], Len, Idx, AccCost) ->
    NewCost = AccCost + (2 * Idx - Len + 1) * H,
    calculate_group_cost_optimized_acc(T, Len, Idx + 1, NewCost).