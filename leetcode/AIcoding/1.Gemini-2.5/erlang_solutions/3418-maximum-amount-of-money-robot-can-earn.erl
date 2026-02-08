-module(solution).
-export([max_amount/2]).

max_amount(CardPoints, K) ->
    N = length(CardPoints),

    if K == 0 -> 0;
       N == 0 -> 0;
       true ->
           CardPointsArray = array:from_list(CardPoints),

           InitialSum = calculate_prefix_sum(CardPointsArray, K),
           MaxScore = InitialSum,

           {_FinalSum, ResultMaxScore} = lists:foldl(
               fun(I, {CurrentSum, MaxAcc}) ->
                   RemovedFromLeftIdx = K - I,
                   AddedFromRightIdx = N - I,

                   RemovedVal = array:get(RemovedFromLeftIdx, CardPointsArray),
                   AddedVal = array:get(AddedFromRightIdx, CardPointsArray),

                   NewSum = CurrentSum - RemovedVal + AddedVal,
                   {NewSum, max(MaxAcc, NewSum)}
               end,
               {InitialSum, MaxScore},
               lists:seq(1, K)
           ),
           ResultMaxScore
    end.

calculate_prefix_sum(Array, Count) ->
    lists:foldl(fun(Idx, Acc) -> Acc + array:get(Idx, Array) end, 0, lists:seq(0, Count - 1)).