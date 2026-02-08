-module(minimum_absolute_difference).
-export([minimumAbsDifference/1]).

minimumAbsDifference(Nums) ->
    Sorted = lists:sort(Nums),
    MinDiff = lists:foldl(fun({A, B}, Acc) -> min(B - A, Acc) end, hd(Sorted), lists:zip(Sorted, tl(Sorted))),
    lists:foldl(fun({A, B}, Acc) -> 
        case B - A of
            Diff when Diff == MinDiff -> [A,B | Acc];
            _ -> Acc
        end
    end, [], lists:zip(Sorted, tl(Sorted))).

minimumAbsDifference(_Args) -> ok.