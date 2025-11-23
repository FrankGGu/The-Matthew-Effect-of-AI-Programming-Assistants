-spec count_operations(Num1 :: integer(), Num2 :: integer()) -> integer().
count_operations(0, _) -> 0;
count_operations(_, 0) -> 0;
count_operations(Num1, Num2) when Num1 >= Num2 ->
    1 + count_operations(Num1 - Num2, Num2);
count_operations(Num1, Num2) -> %% Num2 > Num1
    1 + count_operations(Num1, Num2 - Num1).