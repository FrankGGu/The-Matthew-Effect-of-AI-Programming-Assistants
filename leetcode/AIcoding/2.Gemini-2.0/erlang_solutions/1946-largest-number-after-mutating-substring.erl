-module(largest_number_after_mutating_substring).
-export([maximum_number/2]).

maximum_number(Number, Mapping) ->
  Digits = string:to_integer_list(Number),
  Len = length(Digits),
  maximum_number(Digits, Mapping, 0, Len, false, []).

maximum_number([], _, _, _, _, Acc) ->
  list_to_string(lists:reverse(Acc));
maximum_number([Digit | Rest], Mapping, Index, Len, Mutated, Acc) ->
  MapValue = lists:nth(Digit + 1, Mapping),
  case Mutated of
    false ->
      case MapValue > Digit of
        true ->
          maximum_number([MapValue | Rest], Mapping, Index + 1, Len, true, [Digit | Acc]);
        false ->
          maximum_number([Digit | Rest], Mapping, Index + 1, Len, false, [Digit | Acc])
      end;
    true ->
      case MapValue >= Digit of
        true ->
          maximum_number([MapValue | Rest], Mapping, Index + 1, Len, true, [Digit | Acc]);
        false ->
          maximum_number([Digit | Rest], Mapping, Index + 1, Len, true, [Digit | Acc])
      end
  end.

list_to_string(List) ->
  list_to_binary(lists:map(fun(X) -> integer_to_list(X) end, List)).