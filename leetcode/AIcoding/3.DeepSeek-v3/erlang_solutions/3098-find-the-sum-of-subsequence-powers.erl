-module(solution).
-export([sum_of_power/1]).

sum_of_power(Nums) ->
    Sorted = lists:sort(Nums),
    sum_of_power(Sorted, 0, 0, 0, #{}).

sum_of_power([], _, _, Total, _) -> Total;
sum_of_power([H | T], Sum, SumSq, Total, DP) ->
    case maps:get(H, DP, undefined) of
        undefined ->
            NewSum = (Sum + H) rem 1000000007,
            NewSumSq = (SumSq + H * H + 2 * H * Sum) rem 1000000007,
            NewTotal = (Total + NewSumSq) rem 1000000007,
            NewDP = maps:put(H, {NewSum, NewSumSq}, DP),
            sum_of_power(T, NewSum, NewSumSq, NewTotal, NewDP);
        {PrevSum, PrevSumSq} ->
            NewSum = (Sum + PrevSum + H) rem 1000000007,
            NewSumSq = (SumSq + PrevSumSq + H * H + 2 * H * PrevSum) rem 1000000007,
            NewTotal = (Total + NewSumSq) rem 1000000007,
            sum_of_power(T, NewSum, NewSumSq, NewTotal, DP)
    end.