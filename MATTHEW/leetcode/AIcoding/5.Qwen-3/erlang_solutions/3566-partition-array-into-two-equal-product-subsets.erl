-module(partition_array_into_two_equal_product_subsets).
-export([canPartition/1]).

canPartition(Nums) ->
    Total = lists:sum(Nums),
    case Total rem 2 of
        0 ->
            Target = Total div 2,
            canPartition(Nums, Target, 1, 0);
        _ ->
            false
    end.

canPartition([], _, _, _) ->
    false;
canPartition([H | T], Target, Index, Current) ->
    case Current * H of
        Product when Product > Target ->
            canPartition(T, Target, Index + 1, Current);
        Product ->
            if
                Product == Target ->
                    true;
                true ->
                    case canPartition(T, Target, Index + 1, Product) of
                        true -> true;
                        _ -> canPartition(T, Target, Index + 1, Current)
                    end
            end
    end.