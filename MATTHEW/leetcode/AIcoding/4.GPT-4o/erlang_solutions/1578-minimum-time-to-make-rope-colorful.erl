-module(solution).
-export([minCost/2]).

minCost(Ropes, Colors) ->
    lists:foldl(fun({Color, Index}, Acc) ->
        case lists:keyfind(Color, 1, Acc) of
            false -> [{Color, 1}] ++ Acc;
            {Color, Count} -> lists:keyreplace(Color, 1, Acc, {Color, Count + 1})
        end
    end, [], lists:zip(Colors, lists:seq(1, length(Colors)))).