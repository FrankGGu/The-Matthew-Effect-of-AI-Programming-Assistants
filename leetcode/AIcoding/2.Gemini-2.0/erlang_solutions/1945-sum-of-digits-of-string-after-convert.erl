-module(sum_of_digits).
-export([get_lucky/2]).

get_lucky(S, K) ->
  Digits = string_to_digits(S),
  lists:foldl(fun(_, Acc) -> transform(Acc) end, Digits, lists:seq(1, K)).

string_to_digits(S) ->
  string:foldl(fun(C, Acc) ->
    Val = C - $a + 1,
    Acc ++ integer_to_digits(Val)
  end, [], S).

integer_to_digits(N) ->
  integer_to_list(N)
  |> lists:map(fun(X) -> X - $0 end).

transform(Digits) ->
  lists:sum(Digits)
  |> integer_to_digits().