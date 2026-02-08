-spec fraction_to_decimal(Numerator :: integer(), Denominator :: integer()) -> unicode:unicode_binary().
fraction_to_decimal(Numerator, Denominator) ->
    sign(Numerator, Denominator) ++
    integer_part(Numerator, Denominator) ++
    fractional_part(Numerator rem Denominator, Denominator, []).

sign(Numerator, Denominator) when Numerator * Denominator < 0 -> "-";
sign(_, _) -> "".

integer_part(Numerator, Denominator) ->
    IntegerPart = div(Numerator, Denominator),
    integer_to_list(IntegerPart).

fractional_part(0, _, _) -> "";
fractional_part(Remainder, Denominator, Seen) ->
    case lists:keyfind(Remainder, 1, Seen) of
        false ->
            NewRemainder = Remainder * 10,
            NextDigit = div(NewRemainder, Denominator),
            fractional_part(NewRemainder rem Denominator, Denominator, [{Remainder, NextDigit} | Seen]) ++ integer_to_list(NextDigit);
        {_, Start} ->
            {BeforeRepeat, AfterRepeat} = lists:split(Start, Seen),
            BeforeRepeat ++ ["("] ++ lists:map(fun({_, Digit}) -> integer_to_list(Digit) end, AfterRepeat) ++ [")"]
    end.
