-module(solution).
-export([max_strength/2]).

max_strength(Numbers, K) ->
    MaxStrength = max_strength_helper(Numbers, K),
    MaxStrength.

max_strength_helper(Numbers, 0) -> 1;
max_strength_helper([], _) -> 0;
max_strength_helper(Numbers, K) ->
    lists:foldl(fun(X, Acc) -> 
        case Acc of 
            {Max, Subarrays} -> 
                case Subarrays of
                    [] -> {Max, [[X]]};
                    _ -> 
                        NewSubarrays = lists:map(fun(List) -> [X | List] end, Subarrays),
                        NewSubarrays ++ lists:map(fun(List) -> List ++ [X] end, Subarrays) 
                end
        end
    end, {0, []}, Numbers).