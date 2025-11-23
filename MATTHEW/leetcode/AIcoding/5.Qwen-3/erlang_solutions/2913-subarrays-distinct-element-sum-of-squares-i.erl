-module(subarrays_distinct_element_sum_of_squares).
-export([sumSquaresOfDistinctElements/1]).

sumSquaresOfDistinctElements(Nums) ->
    sumSquaresOfDistinctElements(Nums, 0, 0, []).

sumSquaresOfDistinctElements([], Acc, _, _) ->
    Acc;
sumSquaresOfDistinctElements([H | T], Acc, Start, Seen) ->
    case lists:member(H, Seen) of
        true ->
            sumSquaresOfDistinctElements(T, Acc, Start + 1, lists:delete(H, Seen));
        false ->
            sumSquaresOfDistinctElements(T, Acc + H * H, Start, [H | Seen])
    end.