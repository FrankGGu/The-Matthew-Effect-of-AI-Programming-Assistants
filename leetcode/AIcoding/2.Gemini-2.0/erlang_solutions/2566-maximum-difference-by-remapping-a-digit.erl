-module(maximum_difference).
-export([maxDiff/1]).

maxDiff(Num) ->
  Digits = integer_to_list(Num),
  maxDiffHelper(Digits).

maxDiffHelper(Digits) ->
  case Digits of
    [] -> 0;
    [H|T] ->
      Max = findMaxDiff(Digits, H);
      Min = findMinDiff(Digits, H);
      Max - Min
  end.

findMaxDiff(Digits, H) ->
  NewDigits = replaceDigit(Digits, H, $9),
  list_to_integer(NewDigits).

findMinDiff(Digits, H) ->
  case lists:nth(1,Digits) of
    $0 ->
      case H of
        $0 ->
          NewDigits = replaceDigit(Digits, H, $1);
          list_to_integer(NewDigits);
        _ ->
           NewDigits = replaceDigit(Digits, H, $0);
           list_to_integer(NewDigits)
      end;
    _ ->
       NewDigits = replaceDigit(Digits, H, $0);
       list_to_integer(NewDigits)
  end.

replaceDigit(Digits, OldDigit, NewDigit) ->
  lists:map(fun(Digit) ->
                case Digit of
                  OldDigit -> NewDigit;
                  _ -> Digit
                end
            end, Digits).