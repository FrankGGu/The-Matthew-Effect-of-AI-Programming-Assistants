-module(number_of_beautiful_integers).
-export([number_of_beautiful_integers/2]).

number_of_beautiful_integers(Low, High) ->
  count_beautiful(High) - count_beautiful(Low - 1).

count_beautiful(Num) ->
  Digits = integer_to_list(Num),
  Len = length(Digits),
  Memo = array:new(Len + 1, [array:new(51, [array:new(51, -1)])]),
  count_beautiful_helper(Digits, 0, 0, 0, true, Memo).

count_beautiful_helper(Digits, Index, Mod, EvenCount, IsTight, Memo) ->
  Len = length(Digits),
  Array = array:get(Index, Memo),
  Array2 = array:get(Mod, Array),
  Cache = array:get(EvenCount, Array2),

  case {Cache, IsTight} of
    {Val, false} when Val >= 0 ->
      Val;
    _ ->
      if Index == Len then
        case Mod of
          0 ->
            if EvenCount * 2 == Len then 1 else 0 end;
          _ ->
            0
        end
      else
        Bound = case IsTight of
          true -> list_to_integer([hd(Digits)]);
          false -> 9
        end,
        Result = lists:foldl(
          fun(Digit, Acc) ->
            NewMod = (Mod * 10 + Digit) rem 50,
            NewEvenCount = case Digit rem 2 of
              0 -> EvenCount + 1;
              _ -> EvenCount
            end,
            NewIsTight = IsTight andalso (Digit == Bound),
            Acc + count_beautiful_helper(tl(Digits), Index + 1, NewMod, NewEvenCount, NewIsTight, Memo)
          end,
          0,
          lists:seq(0, Bound)
        ),
        case IsTight of
          false ->
            NewArray2 = array:set(EvenCount, Result, Array2),
            NewArray = array:set(Mod, NewArray2, Array),
            NewMemo = array:set(Index, NewArray, Memo),
            array:set(Index, NewMemo, Memo);
          _ ->
            ok
        end,
        Result
      end
  end.