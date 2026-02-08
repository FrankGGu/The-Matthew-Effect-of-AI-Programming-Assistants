-module(final_array_state_k_multiplication_operations_ii).
-export([final_array_after_operations/2]).

final_array_after_operations(Nums, Queries) ->
    lists:foldl(fun(Query, Acc) ->
                        case Query of
                            {Index, Value} ->
                                lists:replace(Index + 1, Value, Acc)
                        end
                    end, Nums, Queries).