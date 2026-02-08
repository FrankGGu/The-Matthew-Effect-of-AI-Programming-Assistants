-module(countOperations).
-export([count_operations/2]).

count_operations(Num1, Num2) ->
    count_operations_helper(Num1, Num2, 0).

count_operations_helper(0, 0, Count) ->
    Count;
count_operations_helper(Num1, Num2, Count) when Num1 >= Num2 ->
    count_operations_helper(Num1 - Num2, Num2, Count + 1);
count_operations_helper(Num1, Num2, Count) ->
    count_operations_helper(Num1, Num2 - Num1, Count + 1).