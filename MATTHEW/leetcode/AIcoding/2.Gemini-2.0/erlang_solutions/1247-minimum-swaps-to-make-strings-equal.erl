-module(minimum_swaps).
-export([min_swaps/2]).

min_swaps(S1, S2) ->
  {XY, YX} = lists:foldl(fun(X, {A, B}) ->
                          case X of
                            {0, 1} -> {A + 1, B};
                            {1, 0} -> {A, B + 1};
                            _ -> {A, B}
                          end
                        end, {0, 0}, lists:zip(S1, S2)),
  if (XY + YX) rem 2 == 1 then
    -1
  else
    XY div 2 + YX div 2 + (XY rem 2) + (YX rem 2)
  end.