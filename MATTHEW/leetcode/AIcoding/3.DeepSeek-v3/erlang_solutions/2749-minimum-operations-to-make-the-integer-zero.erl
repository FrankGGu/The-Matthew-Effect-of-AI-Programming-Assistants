-spec minimum_operations(Num1 :: integer(), Num2 :: integer()) -> integer().
minimum_operations(Num1, Num2) ->
    minimum_operations(Num1, Num2, 0).

minimum_operations(Num1, Num2, Steps) when Num1 =< 0 ->
    if 
        Num1 == 0 -> Steps;
        true -> -1
    end;
minimum_operations(Num1, Num2, Steps) ->
    case (Num1 - Steps * Num2) band 1 of
        1 when Steps > 0 -> -1;
        1 -> minimum_operations(Num1 - (1 + Steps * Num2), Num2, Steps + 1);
        0 -> 
            K = Num1 - Steps * Num2,
            if
                K >= 0 andalso K >= Steps -> Steps;
                true -> minimum_operations(Num1, Num2, Steps + 1)
            end
    end.