-module(solution).
-export([make_equal/1]).

make_equal(Nums) ->
  make_equal(Nums, 0, 0).

make_equal([], _, _) ->
  true;
make_equal([H|T], Sum, Prev) ->
  NewSum = Sum + H - Prev,
  if NewSum < 0 ->
    false
  else
    make_equal(T, NewSum, H)
  end.