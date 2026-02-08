-module(solution).
-export([sum_even_after_queries/2]).

sum_even_after_queries(Nums, Queries) ->
    EvenSum = lists:sum(lists:filterfun(fun(X) -> X rem 2 == 0 end, Nums)),
    lists:foldl(fun({Val, Index}, Acc) ->
        NewVal = lists:nth(Index + 1, Nums) + Val,
        NewNums = lists:replace_at(Nums, Index + 1, NewVal),
        NewEvenSum = if NewVal rem 2 == 0 -> EvenSum + Val; NewVal rem 2 == 1 -> EvenSum - (NewVal - Val); true -> EvenSum end,
        {NewEvenSum, NewNums}
    end, {EvenSum, Nums}, Queries).