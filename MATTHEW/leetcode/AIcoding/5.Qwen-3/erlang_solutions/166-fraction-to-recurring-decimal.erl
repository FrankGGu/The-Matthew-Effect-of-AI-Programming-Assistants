-module(fraction_to_recurring_decimal).
-export([fraction_to_recurring_decimal/2]).

fraction_to_recurring_decimal(Numerator, Denominator) ->
    case Numerator of
        0 -> "0";
        _ ->
            Sign = if
                       (Numerator > 0 andalso Denominator > 0) orelse (Numerator < 0 andalso Denominator < 0) -> "";
                       true -> "-"
                   end,
            AbsNumerator = abs(Numerator),
            AbsDenominator = abs(Denominator),
            {IntegerPart, Remainder} = integer_part(AbsNumerator, AbsDenominator),
            if
                Remainder == 0 -> Sign ++ integer_to_list(IntegerPart);
                true ->
                    {DecimalPart, RemainderMap} = get_decimal_part(Remainder, AbsDenominator, [], #{}),
                    case maps:is_key(Remainder, RemainderMap) of
                        true ->
                            Index = maps:get(Remainder, RemainderMap),
                            IntegerPartStr = integer_to_list(IntegerPart),
                            Before = lists:sublist(DecimalPart, Index),
                            After = lists:sublist(DecimalPart, Index + 1, length(DecimalPart) - Index),
                            Sign ++ IntegerPartStr ++ "." ++ lists:flatten([lists:append(Before, ["("]), After, [")"]]);
                        false ->
                            Sign ++ integer_to_list(IntegerPart) ++ "." ++ lists:flatten(DecimalPart)
                    end
            end
    end.

integer_part(N, D) ->
    Q = N div D,
    R = N rem D,
    {Q, R}.

get_decimal_part(Remainder, Denominator, Acc, Map) ->
    case Remainder of
        0 -> {lists:reverse(Acc), Map};
        _ ->
            case maps:is_key(Remainder, Map) of
                true -> {lists:reverse(Acc), Map};
                false ->
                    NewMap = maps:put(Remainder, length(Acc), Map),
                    NextRemainder = (Remainder * 10) rem Denominator,
                    Digit = (Remainder * 10) div Denominator,
                    get_decimal_part(NextRemainder, Denominator, [Digit | Acc], NewMap)
            end
    end.