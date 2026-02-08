-module(sequential_digits).
-export([sequential_digits/2]).

sequential_digits(Low, High) ->
  sequential_digits(Low, High, []).

sequential_digits(Low, High, Acc) ->
  Digits = "123456789",
  LenLow = length(integer_to_list(Low)),
  LenHigh = length(integer_to_list(High)),
  sequential_digits_helper(Low, High, Digits, LenLow, LenHigh, Acc).

sequential_digits_helper(Low, High, Digits, Len, MaxLen, Acc) when Len > MaxLen ->
  lists:reverse(lists:sort(Acc));
sequential_digits_helper(Low, High, Digits, Len, MaxLen, Acc) ->
  sequential_digits_helper_inner(Low, High, Digits, Len, 1, Acc).

sequential_digits_helper_inner(Low, High, Digits, Len, Start, Acc) when Start + Len > 10 ->
  sequential_digits_helper(Low, High, Digits, Len + 1, length(integer_to_list(High)), Acc);
sequential_digits_helper_inner(Low, High, Digits, Len, Start, Acc) ->
  Sub = string:sub(Digits, Start, Len),
  Num = list_to_integer(string:to_list(Sub)),
  case Num of
    N when N >= Low andalso N =< High ->
      sequential_digits_helper_inner(Low, High, Digits, Len, Start + 1, [N|Acc]);
    N when N > High ->
      sequential_digits_helper(Low, High, Digits, Len + 1, length(integer_to_list(High)), Acc);
    _ ->
      sequential_digits_helper_inner(Low, High, Digits, Len, Start + 1, Acc)
  end.