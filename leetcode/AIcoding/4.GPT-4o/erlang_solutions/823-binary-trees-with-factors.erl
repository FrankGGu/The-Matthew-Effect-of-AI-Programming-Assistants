-module(solution).
-export([numFactoredBinaryTrees/1]).

numFactoredBinaryTrees(Nodes) ->
    NodesSorted = lists:sort(Nodes),
    NodeMap = maps:from_list([{X, 1} || X <- NodesSorted]),
    lists:foldl(fun(Node, Acc) ->
        Count = lists:foldl(fun(Factor, InnerAcc) ->
            case maps:is_key(Factor, NodeMap) of
                true ->
                    InnerAcc + (maps:get(Factor, NodeMap) * maps:get(Node div Factor, NodeMap));
                false -> InnerAcc
            end
        end, 0, [X || X <- lists:seq(1, trunc(math:sqrt(Node)))]).
        NewCount = (Count + 1) mod 1000000007,
        maps:put(Node, NewCount, NodeMap)
    end, NodeMap, NodesSorted),
    lists:foldl(fun({_, Value}, Acc) -> (Acc + Value) mod 1000000007 end, 0, maps:to_list(NodeMap)).