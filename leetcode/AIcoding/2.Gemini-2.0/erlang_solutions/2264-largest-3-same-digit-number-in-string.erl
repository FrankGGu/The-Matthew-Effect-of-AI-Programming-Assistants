-module(largest_3_same_digit).
-export([largestGoodInteger/1]).

largestGoodInteger(Num) ->
  largestGoodInteger(Num, "").

largestGoodInteger("", Acc) ->
  Acc;
largestGoodInteger([A, A, A | Rest], Acc) ->
  Digit = integer_to_list(A - $0),
  NewAcc =
    case Acc of
      "" -> Digit;
      _ ->
        OldDigit = list_to_integer(Acc),
        NewDigit = list_to_integer(Digit),
        if NewDigit > OldDigit -> Digit
        else Acc
        end
    end,
  largestGoodInteger(Rest, NewAcc);
largestGoodInteger([_ | Rest], Acc) ->
  largestGoodInteger(Rest, Acc).