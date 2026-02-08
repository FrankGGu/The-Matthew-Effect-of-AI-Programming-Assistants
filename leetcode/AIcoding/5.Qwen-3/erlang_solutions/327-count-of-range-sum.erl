-module(count_of_range_sum).
-export([count_range_sum/2]).

count_range_sum(Nums, [Lower, Upper]) ->
    Sum = lists:foldl(fun(X, Acc) -> [X + hd(Acc) | Acc] end, [0], Nums),
    count(Sum, Lower, Upper, 0).

count([], _, _, Acc) ->
    Acc;
count([H | T], Lower, Upper, Acc) ->
    NewAcc = Acc + count_less(T, H - Upper) - count_less(T, H - Lower - 1),
    count(T, Lower, Upper, NewAcc).

count_less([], _) ->
    0;
count_less([H | T], Target) ->
    if
        H =< Target ->
            1 + count_less(T, Target);
        true ->
            count_less(T, Target)
    end.