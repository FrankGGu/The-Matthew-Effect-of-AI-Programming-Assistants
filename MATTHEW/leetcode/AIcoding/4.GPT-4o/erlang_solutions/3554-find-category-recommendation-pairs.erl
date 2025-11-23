-module(solution).
-export([recommend_pairs/2]).

recommend_pairs/2 ->
    lists:foldl(fun({C1, C2}, Acc) ->
        case lists:member(C1, Acc) of
            true -> Acc;
            false -> [C1 | Acc]
        end
    end, [], lists:flatmap(fun({C1, C2}) -> [{C1, C2}, {C2, C1}] end, lists:zip([1, 2, 3, 4], [3, 4, 5, 6]))).