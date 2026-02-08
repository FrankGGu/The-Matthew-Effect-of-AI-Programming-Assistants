-module(smallest_string).
-export([smallest_string/1]).

smallest_string(S) ->
  smallest_string_helper(S, 1).

smallest_string_helper([], _) ->
  [];
smallest_string_helper([H|T], 1) ->
  case H =/= $a of
    true ->
      smallest_string_helper2([H|T]),
    false ->
      [H|smallest_string_helper(T,1)]
  end.

smallest_string_helper2([]) ->
  [];
smallest_string_helper2([H|T]) ->
  case H =/= $a of
    true ->
      [H-1|smallest_string_helper2(T)],
    false ->
      [H|T]
  end.