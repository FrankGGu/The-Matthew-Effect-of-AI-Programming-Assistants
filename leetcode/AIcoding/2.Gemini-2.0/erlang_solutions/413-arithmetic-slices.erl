-module(arithmetic_slices).
-export([number_of_arithmetic_slices/1]).

number_of_arithmetic_slices(A) ->
    number_of_arithmetic_slices(A, 0, 0).

number_of_arithmetic_slices([_,_|_] = A, Count, Acc) ->
    {NewCount, NewAcc} = count_slices(A, Count, Acc),
    NewAcc;
number_of_arithmetic_slices(_, _, Acc) ->
    Acc.

count_slices([A, B, C | Rest], Count, Acc) ->
    Diff = B - A,
    if C - B == Diff ->
        NewCount = Count + 1,
        NewAcc = Acc + NewCount,
        count_slices([B, C | Rest], NewCount, NewAcc);
    true ->
        {0, Acc}
    end;
count_slices(_, Count, Acc) ->
    {0, Acc}.