-module(bintree).
-export([num_factored_binary_trees/1]).

num_facted_binary_trees(Nums) ->
    Sorted = lists:sort(Nums),
    Map = maps:from_list([{N, 0} || N <- Sorted]),
    num_facted_binary_trees(Sorted, Map, 0).

num_facted_binary_trees([], _, Acc) ->
    Acc;
num_facted_binary_trees([N | Rest], Map, Acc) ->
    Count = count_trees(N, Map),
    num_facted_binary_trees(Rest, Map, Acc + Count).

count_trees(N, Map) ->
    case maps:get(N, Map, 0) of
        0 ->
            Count = count_trees_helper(N, Map),
            maps:update(N, Count, Map),
            Count;
        C ->
            C
    end.

count_trees_helper(N, Map) ->
    Count = 1,
    lists:foldl(fun(X, Acc) ->
                    if X >= N -> Acc;
                       true ->
                            case maps:is_key(N div X, Map) of
                                true when N rem X == 0 ->
                                    Acc + (maps:get(X, Map) * maps:get(N div X, Map));
                                _ -> Acc
                            end
                    end
                end, Count, maps:keys(Map)).