-module(balanced_string).
-export([check_balanced/1]).

check_balanced(S) ->
  check_balanced(S, 0, 0, 0, 0).

check_balanced([], A, B, C, D) ->
  Max = max([A, B, C, D]),
  Min = min([A, B, C, D]),
  Max - Min =< 1;
check_balanced([H|T], A, B, C, D) ->
  case H of
    $a -> check_balanced(T, A + 1, B, C, D);
    $b -> check_balanced(T, A, B + 1, C, D);
    $c -> check_balanced(T, A, B, C + 1, D);
    $d -> check_balanced(T, A, B, C, D + 1)
  end.

max([A, B, C, D]) ->
  max(max(A, B), max(C, D)).

min([A, B, C, D]) ->
  min(min(A, B), min(C, D)).