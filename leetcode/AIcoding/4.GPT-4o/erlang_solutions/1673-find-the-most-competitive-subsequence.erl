-module(solution).
-export([most_competitive/2]).

most_competitive(N, nums) ->
    K = length(nums) - N,
    most_competitive(nums, K, []).

most_competitive([], _, Acc) -> 
    lists:reverse(Acc);
most_competitive(Nums, K, Acc) when K >= length(Nums) ->
    [];
most_competitive([H | T], K, Acc) ->
    case Acc of
        [] -> most_competitive(T, K, [H | Acc]);
        [A | _] when A <= H -> most_competitive(T, K, [H | Acc]);
        _ when K > 0 -> 
            most_competitive(T, K - 1, Acc);
        _ -> 
            most_competitive(T, K, Acc)
    end.