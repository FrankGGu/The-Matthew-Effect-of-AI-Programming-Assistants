-module(minimum_operations_k_subarrays).
-export([min_operations/2]).

min_operations(Nums, K) ->
    length(Nums) - max_frequency(Nums, K).

max_frequency(Nums, K) ->
    max_frequency_helper(Nums, K, []).

max_frequency_helper([], _K, Frequencies) ->
    case Frequencies of
        [] -> 0;
        _ -> lists:max(Frequencies)
    end;
max_frequency_helper(Nums, K, Frequencies) ->
    max_frequency_helper(tl(Nums), K, [frequency(hd(Nums), Nums) | Frequencies]).

frequency(Element, List) ->
    lists:foldl(
        fun(X, Acc) ->
            case X of
                Element -> Acc + 1;
                _ -> Acc
            end
        end,
        0,
        List
    ).