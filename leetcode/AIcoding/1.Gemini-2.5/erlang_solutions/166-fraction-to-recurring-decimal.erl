-module(solution).
-export([fraction_to_decimal/2]).

fraction_to_decimal(Numerator, Denominator) ->
    if Numerator == 0 ->
            "0";
       true ->
            Sign = if (Numerator < 0 andalso Denominator > 0) orelse (Numerator > 0 andalso Denominator < 0) ->
                           "-";
                      true ->
                           ""
                   end,
            AbsNum = abs(Numerator),
            AbsDen = abs(Denominator),

            IntegerPart = AbsNum div AbsDen,
            Remainder = AbsNum rem AbsDen,

            IntegerPartStr = integer_to_list(IntegerPart),

            if Remainder == 0 ->
                   Sign ++ IntegerPartStr;
               true ->
                   DecimalPartStr = decimal_part(Remainder, AbsDen, 0, #{}, []),
                   Sign ++ IntegerPartStr ++ "." ++ DecimalPartStr
            end
    end.

decimal_part(CurrentRemainder, Denominator, Position, RemainderMap, DigitsAccumulator) ->
    if CurrentRemainder == 0 ->
           lists:flatten(lists:reverse(DigitsAccumulator));
       maps:is_key(CurrentRemainder, RemainderMap) ->
           CycleStartPos = maps:get(CurrentRemainder, RemainderMap),
           ReversedDigits = lists:reverse(DigitsAccumulator),
           {BeforeCycle, InCycle} = lists:split(CycleStartPos, ReversedDigits),
           lists:flatten(BeforeCycle ++ ["(" | InCycle] ++ [")"]);
       true ->
           NewRemainderMap = maps:put(CurrentRemainder, Position, RemainderMap),
           MultipliedRemainder = CurrentRemainder * 10,
           Digit = MultipliedRemainder div Denominator,
           NextRemainder = MultipliedRemainder rem Denominator,
           decimal_part(NextRemainder, Denominator, Position + 1, NewRemainderMap, [integer_to_list(Digit) | DigitsAccumulator])
    end.