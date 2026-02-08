-spec multiply(Num1 :: unicode:unicode_binary(), Num2 :: unicode:unicode_binary()) -> unicode:unicode_binary().
multiply(Num1, Num2) ->
    multiply_strings(binary_to_list(Num1), binary_to_list(Num2)).

multiply_strings(Num1, Num2) ->
    Result = multiply_digits(Num1, Num2, length(Num1), length(Num2), []),
    list_to_binary(Result).

multiply_digits([], _, _, _, Result) -> Result;
multiply_digits(_, [], _, _, Result) -> Result;
multiply_digits([Digit1 | Rest1], [Digit2 | Rest2], Len1, Len2, Acc) ->
    Product = (Digit1 - $0) * (Digit2 - $0),
    NewAcc = [Product rem 10 + $0 | Acc],
    multiply_digits(Rest1, Rest2, Len1 - 1, Len2 - 1, NewAcc).
