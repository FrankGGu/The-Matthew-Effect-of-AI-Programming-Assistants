-module(solution).
-export([sum_of_imbalance_numbers/1]).

sum_of_imbalance_numbers(List) ->
    Subarrays = lists:foldl(fun(X, Acc) -> [lists:append([Y, [X]]) || Y <- Acc] ++ [[X]] end, [[]], List),
    lists:sum(lists:map(fun(Sub) -> imbalance(Sub) end, Subarrays)).

imbalance(Sub) ->
    Unique = lists:usort(Sub),
    lists:map(fun(X) -> count_less_than(X, Sub) - count_greater_than(X, Sub) end, Unique).

count_less_than(X, List) -> 
    lists:length(lists:filter(fun(Y) -> Y < X end, List)).

count_greater_than(X, List) -> 
    lists:length(lists:filter(fun(Y) -> Y > X end, List)).