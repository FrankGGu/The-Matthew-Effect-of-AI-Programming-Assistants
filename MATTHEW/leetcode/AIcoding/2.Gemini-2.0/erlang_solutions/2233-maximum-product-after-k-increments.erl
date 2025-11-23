-module(maximum_product_after_k_increments).
-export([maximum_product/2]).

maximum_product(Nums, K) ->
    maximum_product_helper(lists:sort(Nums), K, 1).

maximum_product_helper([H|T], K, Acc) ->
    case T of
        [] ->
            Acc * (H + K) rem 1000000007;
        [Next | _] ->
            Diff = Next - H;
            case K >= Diff of
                true ->
                    maximum_product_helper([Next | lists:delete(Next, T)], K - Diff, Acc * Next rem 1000000007);
                false ->
                    maximum_product_helper([H + K | T], 0, Acc * (H + K) rem 1000000007)
            end
    end;
maximum_product_helper([], 0, Acc) ->
	Acc.

maximum_product_helper([], K, Acc) ->
    Acc.