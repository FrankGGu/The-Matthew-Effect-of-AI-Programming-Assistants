-module(ugly_number_ii).
-export([nthUglyNumber/1]).

nthUglyNumber(N) ->
  lists:nth(N, solve()).

solve() ->
  solve([1], 1, 1, 1, []).

solve(Uglys, I2, I3, I5, Acc) ->
  case length(Uglys) of
    1690 ->
      lists:reverse(Uglys);
    _ ->
      V2 = lists:nth(I2, Uglys) * 2,
      V3 = lists:nth(I3, Uglys) * 3,
      V5 = lists:nth(I5, Uglys) * 5,
      Min = min(V2, min(V3, V5)),
      Uglys2 = Uglys ++ [Min],
      I2New = if Min == V2 then I2 + 1 else I2 end,
      I3New = if Min == V3 then I3 + 1 else I3 end,
      I5New = if Min == V5 then I5 + 1 else I5 end,
      solve(Uglys2, I2New, I3New, I5New, Acc).
  end.