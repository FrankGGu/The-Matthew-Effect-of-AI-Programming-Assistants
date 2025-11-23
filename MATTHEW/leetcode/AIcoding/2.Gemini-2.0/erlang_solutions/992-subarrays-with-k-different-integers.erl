-module(subarrays_with_k_different_integers).
-export([num_subarrays_with_k_distinct/2]).

num_subarrays_with_k_distinct(A, K) ->
    at_most_k_distinct(A, K) - at_most_k_distinct(A, K - 1).

at_most_k_distinct(A, K) ->
    at_most_k_distinct(A, K, 0, 0, maps:new(), 0).

at_most_k_distinct(A, K, Left, Right, CountMap, Count) ->
    case Right >= length(A) of
        true ->
            Count;
        false ->
            case maps:is_key(lists:nth(Right + 1, A), CountMap) of
                true ->
                    NewCountMap = maps:update(lists:nth(Right + 1, A), maps:get(lists:nth(Right + 1, A), CountMap) + 1, CountMap),
                    at_most_k_distinct(A, K, Left, Right + 1, NewCountMap, Count + Right - Left + 1);
                false ->
                    case maps:size(CountMap) < K of
                        true ->
                            NewCountMap = maps:put(lists:nth(Right + 1, A), 1, CountMap),
                            at_most_k_distinct(A, K, Left, Right + 1, NewCountMap, Count + Right - Left + 1);
                        false ->
                            {ElementToRemove, _} = lists:keyfind(1, 2, maps:to_list(CountMap)),
                            NewCountMap1 = maps:remove(ElementToRemove, CountMap),
                            NewCountMap2 = maps:put(lists:nth(Right + 1, A), 1, NewCountMap1),
                            at_most_k_distinct(A, K, Left + 1, Right + 1, NewCountMap2, Count);
                    end
            end
    end.