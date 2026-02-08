-spec fraction_to_decimal(Numerator :: integer(), Denominator :: integer()) -> unicode:unicode_binary().
fraction_to_decimal(Numerator, Denominator) ->
    case Denominator of
        0 -> <<"NaN">>;
        _ ->
            Sign = if (Numerator < 0) xor (Denominator < 0) -> <<"-">>; true -> <<>> end,
            N = abs(Numerator),
            D = abs(Denominator),
            IntegerPart = N div D,
            Remainder = N rem D,
            case Remainder of
                0 -> <<Sign/binary, (integer_to_binary(IntegerPart))/binary>>;
                _ ->
                    DecimalPart = decimal_part(Remainder * 10, D, [], #{}),
                    <<Sign/binary, (integer_to_binary(IntegerPart))/binary, ".", DecimalPart/binary>>
            end
    end.

decimal_part(0, _, Acc, _) ->
    list_to_binary(lists:reverse(Acc));
decimal_part(N, D, Acc, Map) ->
    case maps:get(N, Map, undefined) of
        undefined ->
            Q = N div D,
            R = N rem D,
            NewMap = maps:put(N, length(Acc), Map),
            decimal_part(R * 10, D, [integer_to_binary(Q) | Acc], NewMap);
        Index ->
            {Recurring, NonRecurring} = lists:split(Index, Acc),
            RecurringStr = list_to_binary(lists:reverse(Recurring)),
            NonRecurringStr = list_to_binary(lists:reverse(NonRecurring)),
            <<NonRecurringStr/binary, "(", RecurringStr/binary, ")">>
    end.