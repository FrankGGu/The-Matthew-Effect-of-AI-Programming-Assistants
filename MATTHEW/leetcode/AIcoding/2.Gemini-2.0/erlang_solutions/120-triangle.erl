-module(triangle).
-export([minimumTotal/1]).

minimumTotal(Triangle) ->
  minimumTotalHelper(Triangle, []).

minimumTotalHelper([], Acc) ->
  lists:min(Acc);
minimumTotalHelper([Row|Rest], Acc) ->
  case Acc of
    [] ->
      minimumTotalHelper(Rest, Row);
    _ ->
      NewAcc = lists:zipwith(fun(X, Y) -> X + Y end, Row, [hd(Acc)|Acc]) ++ [hd(lists:reverse(Acc)) + lists:last(Row)],
      minimumTotalHelper(Rest, NewAcc)
  end.