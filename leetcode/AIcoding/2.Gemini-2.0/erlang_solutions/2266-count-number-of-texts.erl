-module(count_texts).
-export([number_of_texts/1]).

number_of_texts(pressed_keys) ->
  N = length(pressed_keys),
  Memo = dict:new(),
  number_of_texts_helper(pressed_keys, N, Memo).

number_of_texts_helper(_PressedKeys, 0, _Memo) ->
  1;
number_of_texts_helper(PressedKeys, N, Memo) ->
  case dict:find(N, Memo) of
    {ok, Value} ->
      Value;
    error ->
      Char = lists:nth(N, PressedKeys),
      MaxLen = get_max_len(Char),
      Result = calculate_result(PressedKeys, N, MaxLen, Memo),
      NewMemo = dict:store(N, Result, Memo),
      Result
  end.

calculate_result(PressedKeys, N, MaxLen, Memo) ->
  Result1 = number_of_texts_helper(PressedKeys, N - 1, Memo),
  case MaxLen of
    3 ->
      if N >= 2 ->
        Result2 = number_of_texts_helper(PressedKeys, N - 2, Memo);
        true -> (Result1 + Result2) rem 1000000007
      else
        Result1 rem 1000000007
      end;
    4 ->
      if N >= 2 ->
        Result2 = number_of_texts_helper(PressedKeys, N - 2, Memo),
        if N >= 3 ->
          Result3 = number_of_texts_helper(PressedKeys, N - 3, Memo),
          if N >= 4 ->
            Result4 = number_of_texts_helper(PressedKeys, N - 4, Memo);
            true -> ((Result1 + Result2) rem 1000000007 + (Result3 + Result4) rem 1000000007) rem 1000000007
          else
            ((Result1 + Result2) rem 1000000007 + Result3) rem 1000000007
          end
        else
          (Result1 + Result2) rem 1000000007
        end
      else
        Result1 rem 1000000007
      end
  end.

get_max_len(Char) ->
  case Char of
    '7' -> 4;
    '9' -> 4;
    _ -> 3
  end.