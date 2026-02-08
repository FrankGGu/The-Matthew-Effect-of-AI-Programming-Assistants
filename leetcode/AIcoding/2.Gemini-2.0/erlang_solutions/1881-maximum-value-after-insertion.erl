-module(maximum_value_after_insertion).
-export([maximum_value_after_insertion/3]).

maximum_value_after_insertion(N, X, I) ->
  maximum_value_after_insertion(N, X, I, []).

maximum_value_after_insertion(N, X, I, Acc) ->
  Digits = string:to_integer_list(N),
  case N of
    _ when N =:= "" -> integer_to_list(X);
    _ when N =/= "" ->
      case N:at(1) of
        $- when I =:= 1 ->
          maximum_value_after_insertion_neg(Digits, X, Acc);
        _ ->
          maximum_value_after_insertion_pos(Digits, X, Acc)
      end
  end.

maximum_value_after_insertion_pos(Digits, X, Acc) ->
  case Digits of
    [] ->
      lists:flatten([Acc, integer_to_list(X)]);
    [Digit | Rest] ->
      case Digit < X of
        true ->
          lists:flatten([Acc, integer_to_list(X), lists:map(fun(D) -> integer_to_list(D) end, Rest)]);
        false ->
          maximum_value_after_insertion_pos(Rest, X, Acc ++ [integer_to_list(Digit)])
      end
  end.

maximum_value_after_insertion_neg(Digits, X, Acc) ->
  case Digits of
    [] ->
      lists:flatten([Acc, integer_to_list(X)]);
    [Digit | Rest] ->
      case Digit > X of
        true ->
          lists:flatten([Acc, integer_to_list(X), lists:map(fun(D) -> integer_to_list(D) end, Rest)]);
        false ->
          maximum_value_after_insertion_neg(Rest, X, Acc ++ [integer_to_list(Digit)])
      end
  end.