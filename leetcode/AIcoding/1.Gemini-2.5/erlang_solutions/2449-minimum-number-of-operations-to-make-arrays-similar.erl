-module(solution).
-export([minimum_operations_to_make_arrays_similar/2]).

minimum_operations_to_make_arrays_similar(Nums, Target) ->
    {NumsOdd, NumsEven} = split_by_parity(Nums),
    {TargetOdd, TargetEven} = split_by_parity(Target),

    SortedNumsOdd = lists:sort(NumsOdd),
    SortedNumsEven = lists:sort(NumsEven),
    SortedTargetOdd = lists:sort(TargetOdd),
    SortedTargetEven = lists:sort(TargetEven),

    CostOdd = calculate_cost(SortedNumsOdd, SortedTargetOdd),
    CostEven = calculate_cost(SortedNumsEven, SortedTargetEven),

    CostOdd + CostEven.

split_by_parity(List) ->
    lists:foldl(fun(X, {OddAcc, EvenAcc}) ->
                        if
                            X rem 2 == 0 -> {OddAcc, [X | EvenAcc]};
                            true -> {[X | OddAcc], EvenAcc}
                        end
                end, {[], []}, List).

calculate_cost(List1, List2) ->
    lists:foldl(fun({N1, N2}, Acc) ->
                        Acc + abs(N1 - N2)
                end, 0, lists:zip(List1, List2)) div 2.