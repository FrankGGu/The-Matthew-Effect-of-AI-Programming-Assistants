-module(base7).
-export([base7/1]).

base7(Num) ->
  base7_helper(abs(Num), []).

base7_helper(0, Acc) ->
  case Acc of
    [] -> "0";
    _ -> lists:reverse(Acc)
  end;
base7_helper(N, Acc) ->
  Remainder = N rem 7,
  Quotient = N div 7,
  base7_helper(Quotient, [integer_to_list(Remainder) | Acc]).