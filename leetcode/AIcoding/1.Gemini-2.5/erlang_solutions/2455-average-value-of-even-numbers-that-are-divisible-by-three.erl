-module(solution).
-export([average_value/1]).

average_value(Nums) ->
    average_value_acc(Nums, 0, 0).

average_value_acc([], Sum, Count) ->
    if Count > 0 ->
        Sum div Count;
    true ->
        0
    end;
average_value_acc([H|T], Sum, Count) ->
    if H rem 6 == 0 ->
        average_value_acc(T, Sum + H, Count + 1);
    true ->
        average_value_acc(T, Sum, Count)
    end.