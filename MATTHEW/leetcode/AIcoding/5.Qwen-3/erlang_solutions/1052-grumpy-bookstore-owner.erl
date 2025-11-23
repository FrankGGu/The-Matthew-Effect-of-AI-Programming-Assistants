-module(grumpy_bookstore_owner).
-export([max_happy/2]).

max_happy(Customers, Grumpy) ->
    N = length(Customers),
    TotalHappy = lists:sum([lists:nth(I, Customers) || I <- lists:seq(1, N), lists:nth(I, Grumpy) == 0]),
    MaxExtra = max_extra(Customers, Grumpy, N, 0, 0, 0),
    TotalHappy + MaxExtra.

max_extra(_, _, 0, _, _, Acc) ->
    Acc;
max_extra(Customers, Grumpy, I, Start, Current, Acc) ->
    if
        lists:nth(I, Grumpy) == 1 ->
            NewCurrent = Current + lists:nth(I, Customers),
            NewAcc = max(Acc, NewCurrent),
            max_extra(Customers, Grumpy, I - 1, Start, NewCurrent, NewAcc);
        true ->
            max_extra(Customers, Grumpy, I - 1, Start, 0, Acc)
    end.