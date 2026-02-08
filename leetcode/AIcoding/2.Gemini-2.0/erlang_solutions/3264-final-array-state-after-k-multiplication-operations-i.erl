-module(final_array_state).
-export([final_array_after_k_operations/2]).

final_array_after_k_operations(Nums, K) ->
    lists:foldl(fun(Num, Acc) ->
                        case Num rem 2 of
                            0 -> Acc;
                            1 ->
                                case K > 0 of
                                    true ->
                                        K1 = K - 1,
                                        lists:reverse([Num * -1 | lists:reverse(Acc)], K1);
                                    false ->
                                        Acc
                                end
                        end
                end, Nums, Nums).