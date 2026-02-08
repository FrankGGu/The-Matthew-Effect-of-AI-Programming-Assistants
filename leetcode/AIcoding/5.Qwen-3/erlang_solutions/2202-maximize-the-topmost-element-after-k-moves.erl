-module(maximize_topmost_element_after_k_moves).
-export([maximumTop/2]).

maximumTop(Nums, K) ->
    case length(Nums) of
        1 ->
            if K rem 2 == 0 -> lists:nth(1, Nums);
               true -> -1
            end;
        _ ->
            if K == 0 -> lists:nth(1, Nums);
               true ->
                   Max = lists:max(lists:sublist(Nums, 1, K)),
                   if K < length(Nums) -> Max;
                      true -> lists:max(Nums)
                   end
            end
    end.