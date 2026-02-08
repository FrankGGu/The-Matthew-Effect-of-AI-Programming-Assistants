-spec count_operations(Num1 :: integer(), Num2 :: integer()) -> integer().
count_operations(Num1, Num2) ->
    count_operations(Num1, Num2, 0).

count_operations(0, 0, Count) -> Count;
count_operations(0, _, Count) -> Count;
count_operations(_, 0, Count) -> Count;
count_operations(Num1, Num2, Count) when Num1 >= Num2 ->
    count_operations(Num1 - Num2, Num2, Count + 1);
count_operations(Num1, Num2, Count) ->
    count_operations(Num1, Num2 - Num1, Count + 1).