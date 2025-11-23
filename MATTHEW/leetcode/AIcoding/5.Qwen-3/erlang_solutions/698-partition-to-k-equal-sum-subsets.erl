-module(partition_to_k_equal_sum_subsets).
-export([can_partition_k_subsets/2]).

can_partition_k_subsets(Nums, K) ->
    Sum = lists:sum(Nums),
    case Sum rem K of
        0 -> 
            Target = Sum div K,
            Sorted = lists:sort(fun(A, B) -> B > A end, Nums),
            can_partition(Sorted, Target, K, 0, [], 0);
        _ -> false
    end.

can_partition(_, _, 0, _, _, _) -> true;
can_partition([], _, _, _, _, _) -> false;
can_partition([H | T], Target, K, Start, Used, CurrentSum) ->
    case lists:nth(Start, Used) of
        0 ->
            case CurrentSum + H of
                Sum when Sum == Target ->
                    NewUsed = lists:sublist(Used, Start) ++ [1] ++ lists:nthtail(Start + 1, Used),
                    can_partition(T, Target, K - 1, 0, NewUsed, 0);
                Sum when Sum < Target ->
                    NewUsed = lists:sublist(Used, Start) ++ [1] ++ lists:nthtail(Start + 1, Used),
                    case can_partition(T, Target, K, Start + 1, NewUsed, Sum) of
                        true -> true;
                        _ -> can_partition([H | T], Target, K, Start + 1, Used, CurrentSum)
                    end;
                _ -> can_partition([H | T], Target, K, Start + 1, Used, CurrentSum)
            end;
        _ -> can_partition([H | T], Target, K, Start + 1, Used, CurrentSum)
    end.