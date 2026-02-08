-module(max_number_of_pairs_in_array).
-export([maximumNumberOfPairs/1]).

maximumNumberOfPairs(Nums) ->
    Count = lists:foldl(fun(N, Acc) -> maps:update_with(N, fun(V) -> V + 1 end, 1, Acc) end, maps:new(), Nums),
    lists:foldl(fun({_K, V}, {Pairs, Remain}) ->
                        Pairs2 = Pairs + (V div 2),
                        Remain2 = Remain + (V rem 2),
                        {Pairs2, Remain2}
                end, {0, 0}, maps:to_list(Count)).

maximumNumberOfPairs(_Args) ->
    maximumNumberOfPairs([]).