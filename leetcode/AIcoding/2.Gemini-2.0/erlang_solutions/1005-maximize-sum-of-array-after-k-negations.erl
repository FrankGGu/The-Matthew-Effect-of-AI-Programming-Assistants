-module(maximize_sum_after_k_negations).
-export([largestSumAfterKNegations/2]).

largestSumAfterKNegations(A, K) ->
    SortedA = lists:sort(A),
    {NewA, NewK} = negateNegatives(SortedA, K, []),
    Sum = lists:sum(NewA),
    if NewK > 0 and NewK rem 2 == 1 then
        MinAbs = lists:min([abs(X) || X <- NewA]),
        Sum - 2 * MinAbs
    else
        Sum
    end.

negateNegatives([], K, Acc) ->
    {lists:reverse(Acc), K};
negateNegatives([H|T], K, Acc) when H < 0 and K > 0 ->
    negateNegatives(T, K - 1, [-H|Acc]);
negateNegatives(A, K, Acc) ->
    {lists:reverse(Acc) ++ A, K}.