-module(smallest_rearranged_number).
-export([smallest_value/1]).

smallest_value(Num) ->
  Digits = integer_to_list(abs(Num)),
  SortedDigits = lists:sort(Digits),
  case Num >= 0 of
    true ->
      case lists:nth(1, SortedDigits) =:= $0 of
        true ->
          FirstNonZero = find_first_non_zero(SortedDigits, 1),
          case FirstNonZero > length(SortedDigits) of
            true ->
              0;
            false ->
              [NonZero] = lists:sublist(SortedDigits, FirstNonZero, 1),
              Zeros = lists:duplicate(FirstNonZero - 1, $0),
              Rest = lists:delete(NonZero, SortedDigits),
              list_to_integer([NonZero | Zeros ++ Rest])
          end;
        false ->
          list_to_integer(SortedDigits)
      end;
    false ->
      list_to_integer([$- | lists:reverse(SortedDigits)])
  end.

find_first_non_zero(Digits, Index) ->
  case Index > length(Digits) of
    true ->
      Index;
    false ->
      case lists:nth(Index, Digits) =:= $0 of
        true ->
          find_first_non_zero(Digits, Index + 1);
        false ->
          Index
      end
  end.