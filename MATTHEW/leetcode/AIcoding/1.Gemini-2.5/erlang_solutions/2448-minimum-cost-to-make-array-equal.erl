-module(solution).
-export([minCost/2]).

minCost(Nums, Cost) ->
    Pairs = lists:zip(Nums, Cost),
    SortedPairs = lists:sort(fun({N1, _}, {N2, _}) -> N1 =< N2 end, Pairs),

    TotalCost = lists:foldl(fun({_, C}, Acc) -> Acc + C end, 0, SortedPairs),

    {WeightedMedian, _} = lists:foldl(
        fun({N, C}, {Median, CurrentCostSum}) ->
            case Median of
                undefined ->
                    NewCurrentCostSum = CurrentCostSum + C,
                    case 2 * NewCurrentCostSum >= TotalCost of
                        true -> {N, NewCurrentCostSum};
                        false -> {undefined, NewCurrentCostSum}
                    end;
                _ ->
                    {Median, CurrentCostSum + C}
            end
        end,
        {undefined, 0},
        SortedPairs
    ),

    lists:foldl(fun({N, C}, Acc) ->
        Acc + abs(N - WeightedMedian) * C
    end, 0, SortedPairs).