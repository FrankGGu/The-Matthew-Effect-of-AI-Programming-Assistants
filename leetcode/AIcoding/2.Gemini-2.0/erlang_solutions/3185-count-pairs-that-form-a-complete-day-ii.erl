-module(solution).
-export([count_pairs/1]).

count_pairs(T) ->
  count_pairs_helper(T, 0).

count_pairs_helper([], Acc) ->
  Acc;
count_pairs_helper([H|Rest], Acc) ->
  Acc1 = Acc + count_smaller(Rest, H),
  count_pairs_helper(Rest, Acc1).

count_smaller([], _) ->
  0;
count_smaller([H|Rest], X) ->
  case is_valid_pair(X, H) of
    true ->
      1 + count_smaller(Rest, X);
    false ->
      count_smaller(Rest, X)
  end.

is_valid_pair(X, Y) ->
  case X < Y of
    true ->
      Delta = Y - X;
    false ->
      Delta = X - Y
  end,
  Delta =< 86400.