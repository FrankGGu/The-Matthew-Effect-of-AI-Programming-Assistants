-module(remove_k_digits).
-export([remove_k_digits/2]).

remove_k_digits(Num, K) ->
  remove_k_digits(Num, K, []).

remove_k_digits("", 0, Acc) ->
  lists:reverse(Acc);
remove_k_digits("", K, Acc) when K > 0 ->
  lists:sublist(lists:reverse(Acc), length(Acc) - K + 1, length(Acc) - (length(Acc) - K));
remove_k_digits(Num, 0, Acc) ->
  lists:reverse(Acc) ++ Num;
remove_k_digits([H|T], K, Acc) ->
  case Acc of
    [] ->
      remove_k_digits(T, K, [H]);
    [Top|Rest] ->
      case H < Top of
        true when K > 0 ->
          remove_k_digits([H|T], K - 1, Rest);
        true ->
          remove_k_digits(T, K, [H | Acc]);
        false ->
          remove_k_digits(T, K, [H | Acc])
      end
  end.

remove_k_digits(Num, K) ->
  Digits = string:to_integer(Num),
  remove_k_digits(integer_to_list(Digits), K).

remove_k_digits(Num, K, Acc) ->
  Digits = string:to_integer(Num),
  Result = remove_k_digits(integer_to_list(Digits), K),
  case Result of
    "" -> "0";
    _ ->
      case string:prefix(Result, "0") of
        true ->
          remove_leading_zeros(Result);
        false ->
          Result
      end
  end.

remove_leading_zeros(Str) ->
  case Str of
    "" -> "0";
    "0" -> "0";
    _ ->
      case string:prefix(Str, "0") of
        true ->
          remove_leading_zeros(string:substr(Str, 2, length(Str) - 1));
        false ->
          Str
      end
  end.

remove_k_digits(Num, K) ->
  Result = remove_k_digits(Num, K, []),
  case Result of
    "" -> "0";
    _ ->
      case string:prefix(Result, "0") of
        true ->
          remove_leading_zeros(Result);
        false ->
          Result
      end
  end.