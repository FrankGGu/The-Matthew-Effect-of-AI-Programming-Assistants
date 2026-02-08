-module(make_string_great).
-export([make_good/1]).

make_good(S) ->
  make_good_helper(S, []).

make_good_helper([], Acc) ->
  lists:reverse(Acc);
make_good_helper([H | T], []) ->
  make_good_helper(T, [H]);
make_good_helper([H | T], [Last | Acc]) ->
  case is_bad(Last, H) of
    true ->
      make_good_helper(T, Acc);
    false ->
      make_good_helper(T, [H, Last | Acc])
  end.

is_bad(A, B) ->
  (A /= B) andalso (string:to_lower([A]) == string:to_lower([B])).