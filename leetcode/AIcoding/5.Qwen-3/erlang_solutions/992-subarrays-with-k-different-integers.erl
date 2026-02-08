-module(solutions).
-export([subarrays_with_k_diff/1]).

subarrays_with_k_diff(Nums) ->
    subarrays_with_k_diff(Nums, 0, 0, 0, dict:new(), 0).

subarrays_with_k_diff([], _, _, _, _, Acc) ->
    Acc;
subarrays_with_k_diff([H | T], Left, Right, Count, Dict, Acc) ->
    case dict:is_key(H, Dict) of
        true ->
            NewDict = dict:update(H, fun(V) -> V + 1 end, Dict),
            case dict:size(NewDict) of
                Count when Count == 0 ->
                    subarrays_with_k_diff(T, Left, Right + 1, Count, NewDict, Acc);
                _ ->
                    if
                        dict:size(NewDict) > Count ->
                            subarrays_with_k_diff(T, Left + 1, Right + 1, Count, dict:erase(H, NewDict), Acc);
                        true ->
                            subarrays_with_k_diff(T, Left, Right + 1, Count, NewDict, Acc + 1)
                    end
            end;
        false ->
            NewDict = dict:store(H, 1, Dict),
            case dict:size(NewDict) of
                Count when Count == 0 ->
                    subarrays_with_k_diff(T, Left, Right + 1, Count, NewDict, Acc);
                _ ->
                    if
                        dict:size(NewDict) > Count ->
                            subarrays_with_k_diff(T, Left + 1, Right + 1, Count, dict:erase(H, NewDict), Acc);
                        true ->
                            subarrays_with_k_diff(T, Left, Right + 1, Count, NewDict, Acc + 1)
                    end
            end
    end.