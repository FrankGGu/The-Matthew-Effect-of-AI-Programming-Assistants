-module(sum_even_after_queries).
-export([sum_even_after_queries/2]).

sum_even_after_queries(Nums, Queries) ->
    Sum = lists:foldl(fun(X, Acc) -> if X rem 2 == 0 -> Acc + X; true -> Acc end end, 0, Nums),
    sum_even_after_queries(Queries, Nums, Sum, []).

sum_even_after_queries([], _, _, Result) ->
    lists:reverse(Result);
sum_even_after_queries([Query | Rest], Nums, Sum, Result) ->
    [Index, Val] = Query,
    OldVal = lists:nth(Index + 1, Nums),
    NewVal = OldVal + Val,
    NewNums = lists:sublist(Nums, Index + 1) ++ [NewVal] ++ lists:sublist(Nums, Index + 2, length(Nums) - Index - 1),
    case OldVal rem 2 of
        0 -> Sum1 = Sum - OldVal;
        _ -> Sum1 = Sum
    end,
    case NewVal rem 2 of
        0 -> Sum2 = Sum1 + NewVal;
        _ -> Sum2 = Sum1
    end,
    sum_even_after_queries(Rest, NewNums, Sum2, [Sum2 | Result]).