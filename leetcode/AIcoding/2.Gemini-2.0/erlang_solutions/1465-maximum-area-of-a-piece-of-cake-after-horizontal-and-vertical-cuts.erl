-module(maximum_area_cake).
-export([max_area/3]).

max_area(H, W, HorizontalCuts, VerticalCuts) ->
  MaxH = max_gap(lists:sort(HorizontalCuts), H),
  MaxW = max_gap(lists:sort(VerticalCuts), W),
  (MaxH * MaxW) rem 1690879991.

max_gap(Cuts, Max) ->
  case Cuts of
    [] ->
      Max;
    [H | T] ->
      lists:foldl(
        fun(X, {Prev, MaxGap}) ->
          {X, max(MaxGap, X - Prev)}
        end,
        {0, H},
        T
      ) of
        {Last, MaxGap} ->
          max(MaxGap, Max - Last)
      end
  end.