-module(min_operations).
-export([min_operations/1]).

min_operations(Nums) ->
    Sum = lists:sum(Nums),
    Target = Sum div 2,
    Sorted = lists:reverse(lists:sort(Nums)),
    do_min_operations(Sorted, 0, 0).

do_min_operations([], _, Acc) ->
    Acc;
do_min_operations([H | T], CurrentSum, Acc) ->
    NewSum = CurrentSum + H,
    if
        NewSum >= Target ->
            Acc + 1;
        true ->
            do_min_operations(T, NewSum, Acc + 1)
    end.