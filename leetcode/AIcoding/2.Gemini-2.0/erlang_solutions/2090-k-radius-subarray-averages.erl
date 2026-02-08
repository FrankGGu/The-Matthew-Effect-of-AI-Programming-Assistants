-module(k_radius_subarray_averages).
-export([get_averages/2]).

get_averages(Nums, K) ->
    N = length(Nums),
    Averages = lists:duplicate(N, -1),
    case N < 2 * K + 1 of
        true ->
            Averages;
        false ->
            {Sum, RestNums} = lists:split(2 * K + 1, Nums),
            lists:nth(K + 1, put_average(Sum, K, RestNums, Averages, K + 1))
    end.

put_average(Sum, K, [], Averages, Index) ->
    lists:nth(Index, lists:put_nth(Index - 1, floor(Sum / (2 * K + 1)), Averages));
put_average(Sum, K, [Next | Rest], Averages, Index) ->
    Prev = lists:nth(1, Averages),
    NewSum = Sum - lists:nth(1, Averages) + Next,
    NewAverages = lists:nth(Index, lists:put_nth(Index - 1, floor(NewSum / (2 * K + 1)), Averages)),
    put_average(NewSum, K, Rest, NewAverages, Index + 1).