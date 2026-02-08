-module(fraction_to_recurring_decimal).
-export([fraction_to_decimal/2]).

fraction_to_decimal(Numerator, Denominator) ->
  Sign = if (Numerator < 0) xor (Denominator < 0) then "-" else "",
  AbsNumerator = abs(Numerator),
  AbsDenominator = abs(Denominator),
  IntegerPart = AbsNumerator div AbsDenominator,
  Remainder = AbsNumerator rem AbsDenominator,
  if Remainder == 0 then
    Sign ++ integer_to_list(IntegerPart)
  else
    {DecimalPart, Recurring} = fraction_to_decimal_helper(Remainder, AbsDenominator, [], []),
    Sign ++ integer_to_list(IntegerPart) ++ "." ++ DecimalPart ++ Recurring
  end.

fraction_to_decimal_helper(0, _, DecimalPart, _) ->
  {lists:flatten(DecimalPart), ""};
fraction_to_decimal_helper(Remainder, Denominator, DecimalPart, Seen) ->
  case lists:keyfind(Remainder, 1, Seen) of
    false ->
      NextNumerator = Remainder * 10,
      Digit = NextNumerator div Denominator,
      NextRemainder = NextNumerator rem Denominator,
      fraction_to_decimal_helper(NextRemainder, Denominator, DecimalPart ++ [integer_to_list(Digit)], [{Remainder, length(DecimalPart)} | Seen]);
    {_, Index} ->
      {lists:flatten(lists:sublist(DecimalPart, 1, Index)), "(" ++ lists:flatten(lists:sublist(DecimalPart, Index + 1, length(DecimalPart) - Index)) ++ ")"}
  end.