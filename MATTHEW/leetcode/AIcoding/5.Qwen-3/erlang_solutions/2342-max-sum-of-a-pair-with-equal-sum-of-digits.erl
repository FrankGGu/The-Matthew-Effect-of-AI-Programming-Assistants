-module(solution).
-export([maximum_sum/1]).

maximum_sum(Nums) ->
    Map = maps:from_list([{digit_sum(N), []} || N <- Nums]),
    lists:foldl(fun(N, Acc) ->
        Sum = digit_sum(N),
        Value = maps:get(Sum, Acc),
        NewValue = [N | Value],
        maps:put(Sum, NewValue, Acc)
    end, Map, Nums),
    Max = lists:max([lists:sum(Pair) || {_, Pair} <- maps:to_list(Map), length(Pair) >= 2]),
    case Max of
        error -> -1;
        _ -> Max
    end.

digit_sum(N) ->
    digit_sum(N, 0).

digit_sum(0, Acc) ->
    Acc;
digit_sum(N, Acc) ->
    digit_sum(N div 10, Acc + (N rem 10)).