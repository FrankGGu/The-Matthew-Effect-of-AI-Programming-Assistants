-module(roman_to_integer).
-export([roman_to_int/1]).

roman_to_int(S) ->
  roman_to_int(S, 0).

roman_to_int([], Acc) ->
  Acc;
roman_to_int([C | Rest], Acc) ->
  Value = roman_value(C),
  case Rest of
    [] ->
      Acc + Value;
    [Next | _] ->
      NextValue = roman_value(Next),
      if Value < NextValue ->
        roman_to_int(Rest, Acc - Value);
      true ->
        roman_to_int(Rest, Acc + Value)
      end
  end.

roman_value($I) -> 1;
roman_value($V) -> 5;
roman_value($X) -> 10;
roman_value($L) -> 50;
roman_value($C) -> 100;
roman_value($D) -> 500;
roman_value($M) -> 1000.