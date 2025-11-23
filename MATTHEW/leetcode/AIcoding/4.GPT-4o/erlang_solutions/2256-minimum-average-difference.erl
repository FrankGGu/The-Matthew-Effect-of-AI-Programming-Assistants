-module(solution).
-export([minimum_average_difference/1]).

minimum_average_difference(Nums) ->
    TotalSum = lists:sum(Nums),
    N = length(Nums),
    lists:foldl(fun({Sum, Index}, Acc) ->
        LeftSum = lists:sum(lists:sublist(Nums, Index + 1)),
        RightSum = TotalSum - LeftSum,
        LeftSize = Index + 1,
        RightSize = N - LeftSize,
        AvgDiff = case RightSize of
            0 -> abs((TotalSum div N) - (LeftSum div LeftSize));
            _ -> abs((TotalSum div N) - (LeftSum div LeftSize)) + abs((TotalSum div N) - (RightSum div RightSize))
        end,
        case Acc of
            {MinDiff, MinIndex} when AvgDiff < MinDiff ->
                {AvgDiff, Index};
            _ -> Acc
        end
    end, {infinity, -1}, lists:zip(Nums, lists:seq(0, N - 1))).