-module(powerful_integers).
-export([powerful_integers/3]).

powerful_integers(X, Y, Bound) ->
  powerful_integers_helper(X, Y, Bound, 0, 0, sets:new()).

powerful_integers_helper(X, Y, Bound, I, J, Acc) ->
  A = math:pow(X, I),
  B = math:pow(Y, J),
  Sum = A + B,
  if
    Sum =< Bound ->
      NewAcc = sets:add_element(Sum, Acc),
      if
        Y =:= 1 ->
          powerful_integers_helper(X, Y, Bound, I + 1, 0, NewAcc);
        true ->
          powerful_integers_helper(X, Y, Bound, I, J + 1, NewAcc)
      end;
    true ->
      if
        X =:= 1 ->
          sets:to_list(Acc);
        true ->
          powerful_integers_helper(X, Y, Bound, I + 1, 0, Acc)
      end
  end.