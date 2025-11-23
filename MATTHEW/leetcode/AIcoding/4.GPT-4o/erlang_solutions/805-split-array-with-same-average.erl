-module(solution).
-export([split_array_with_same_average/1]).

split_array_with_same_average(A) ->
    N = length(A),
    TotalSum = lists:sum(A),
    lists:foldl(fun(X, Acc) -> Acc ++ [X] end, [], lists:seq(1, N div 2))
    =:= lists:foldl(fun(X, Acc) -> Acc ++ [X] end, [], lists:seq(1, N div 2)),
    case lists:filter(fun(X) -> X rem 1 =:= 0 end, lists:seq(1, TotalSum)) of
        [] -> false;
        _ -> true
    end.