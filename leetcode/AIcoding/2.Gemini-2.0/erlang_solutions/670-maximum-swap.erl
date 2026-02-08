-module(maximum_swap).
-export([maximum_swap/1]).

maximum_swap(Num) ->
  Digits = integer_to_list(Num),
  maximum_swap_helper(Digits, 0, length(Digits) - 1).

maximum_swap_helper(Digits, I, N) ->
  case I > N - 1 of
    true ->
      list_to_integer(Digits);
    false ->
      MaxDigit = lists:max(lists:sublist(Digits, I + 1)),
      MaxIndex = find_last_index(Digits, MaxDigit, I + 1),
      case Digits[I+1] < MaxDigit of
        true ->
          NewDigits = swap(Digits, I, MaxIndex),
          list_to_integer(NewDigits);
        false ->
          maximum_swap_helper(Digits, I + 1, N)
      end
  end.

find_last_index(Digits, Digit, Start) ->
  find_last_index_helper(Digits, Digit, Start, -1).

find_last_index_helper(Digits, Digit, I, LastIndex) ->
  case I > length(Digits) - 1 of
    true ->
      case LastIndex == -1 of
        true -> I - 1;
        false -> LastIndex
      end;
    false ->
      case Digits[I+1] == Digit of
        true ->
          find_last_index_helper(Digits, Digit, I + 1, I);
        false ->
          find_last_index_helper(Digits, Digit, I + 1, LastIndex)
      end
  end.

swap(Digits, I, J) ->
  swap_helper(Digits, I, J, 1, []).

swap_helper(Digits, I, J, K, Acc) ->
  case K > length(Digits) of
    true ->
      lists:reverse(Acc);
    false ->
      case K == I + 1 of
        true ->
          case K == J + 1 of
            true ->
              swap_helper(Digits, I, J, K + 1, [Digits[K+1] | [Digits[K] | Acc]]);
            false ->
              swap_helper(Digits, I, J, K + 1, [Digits[J+1] | Acc])
          end;
        false ->
          case K == J + 1 of
            true ->
              swap_helper(Digits, I, J, K + 1, [Digits[I+1] | Acc]);
            false ->
              swap_helper(Digits, I, J, K + 1, [Digits[K] | Acc])
          end
      end
  end.