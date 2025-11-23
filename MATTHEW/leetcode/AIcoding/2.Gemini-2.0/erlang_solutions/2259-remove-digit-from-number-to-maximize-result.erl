-module(remove_digit).
-export([remove_digit/2]).

remove_digit(Number, Digit) ->
  remove_digit(Number, Digit, 0, []).

remove_digit(Number, Digit, Index, Acc) ->
  case string:len(Number) of
    Index ->
      lists:max(Acc);
    _ ->
      case string:substr(Number, Index + 1, 1) of
        Digit ->
          NewNumber = string:concat(string:substr(Number, 1, Index), string:substr(Number, Index + 2, string:len(Number))),
          remove_digit(Number, Digit, Index + 1, [NewNumber | Acc]);
        _ ->
          remove_digit(Number, Digit, Index + 1, Acc)
      end
  end.