-module(solution).
-export([min_sum_square_diff/4]).

min_sum_square_diff(Nums1, Nums2, K1, K2) ->
    Diffs = lists:sort(fun(A, B) -> A >= B end, 
        [abs(X - Y) || {X, Y} <- lists:zip(Nums1, Nums2)]),
    K = K1 + K2,
    {Diffs1, _} = reduce_diffs(Diffs, K),
    lists:sum([D * D || D <- Diffs1]).

reduce_diffs(Diffs, 0) ->
    {Diffs, 0};
reduce_diffs([], _K) ->
    {[], 0};
reduce_diffs([D | Rest], K) ->
    case Rest of
        [] ->
            MaxReduce = K,
            Reduced = max(0, D - MaxReduce),
            {[Reduced], K - (D - Reduced)};
        [Next | _] ->
            MaxReducePerStep = D - Next,
            if
                MaxReducePerStep =:= 0 ->
                    reduce_diffs(Rest, K);
                MaxReducePerStep * length([D | Rest]) =< K ->
                    NewK = K - MaxReducePerStep * length([D | Rest]),
                    NewD = D - MaxReducePerStep,
                    {NewRest, RemainingK} = reduce_diffs([NewD | Rest], NewK),
                    {NewRest, RemainingK};
                true ->
                    ReduceEach = K div length([D | Rest]),
                    Remaining = K rem length([D | Rest]),
                    NewD = D - ReduceEach,
                    Prefix = lists:duplicate(Remaining, NewD - 1),
                    Suffix = lists:duplicate(length([D | Rest]) - Remaining, NewD),
                    {Prefix ++ Suffix, 0}
            end
    end.