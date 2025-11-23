-module(fascinating).
-export([is_fascinating/1]).

is_fascinating(N) ->
  S = integer_to_list(N) ++ integer_to_list(N * 2) ++ integer_to_list(N * 3),
  case lists:sort(S) of
    "123456789" ->
      true;
    _ ->
      false
  end.