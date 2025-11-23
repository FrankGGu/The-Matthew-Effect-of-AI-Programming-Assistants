-module(max_sum_queries).
-export([maximum_sum_queries/2]).

maximum_sum_queries(Nums1, Queries) ->
    Pairs = lists:zip(Nums1, lists:nth(2, Queries)),
    SortedPairs = lists:sort(fun({X1, Y1}, {X2, Y2}) -> 
        if X1 =/= X2 -> X1 > X2; true -> Y1 > Y2 end 
    end, Pairs),
    Processed = process_pairs(SortedPairs, []),
    lists:map(fun({X, Y}) -> 
        case find_min_y(Processed, X, Y) of 
            -1 -> -1;
            Val -> Val
        end
    end, Queries).

process_pairs([], Acc) ->
    lists:reverse(Acc);
process_pairs([{X, Y} | Rest], Acc) ->
    case Acc of
        [] -> 
            process_pairs(Rest, [{X, Y, X + Y}]);
        [{PrevX, PrevY, PrevSum} | _] ->
            if Y > PrevY ->
                process_pairs(Rest, [{X, Y, X + Y} | Acc]);
            true ->
                process_pairs(Rest, Acc)
            end
    end.

find_min_y([], _, _) ->
    -1;
find_min_y([{X, Y, Sum} | Rest], TargetX, TargetY) ->
    if X >= TargetX andalso Y >= TargetY ->
        Sum;
    true ->
        find_min_y(Rest, TargetX, TargetY)
    end.