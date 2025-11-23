-module(resulting_string_after_adjacent_removals).
-export([make_good/1]).

make_good(S) ->
  make_good_helper(string:to_list(S), []).

make_good_helper([], Acc) ->
  lists:reverse(Acc);
make_good_helper([H|T], []) ->
  make_good_helper(T, [H]);
make_good_helper([H|T], [Last|Acc]) ->
  case is_opposite(H, Last) of
    true ->
      make_good_helper(T, Acc);
    false ->
      make_good_helper(T, [H, Last|Acc])
  end.

is_opposite(A, B) ->
  abs(A - B) == 32.