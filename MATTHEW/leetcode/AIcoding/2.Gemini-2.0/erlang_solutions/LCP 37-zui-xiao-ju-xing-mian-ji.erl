-module(min_area_rect).
-export([minAreaRect/1]).

minAreaRect(Points) ->
  min_area_rect(Points, sets:new()).

min_area_rect([], _Seen) ->
  0;
min_area_rect([Point | Rest], Seen) ->
  X = element(1, Point),
  Y = element(2, Point),
  min_area_rect_helper(Rest, Seen, X, Y, 16#7fffffff).

min_area_rect_helper([], _Seen, _X, _Y, MinArea) ->
  case MinArea == 16#7fffffff of
    true -> 0;
    false -> MinArea
  end;
min_area_rect_helper([Point | Rest], Seen, X1, Y1, MinArea) ->
  X2 = element(1, Point),
  Y2 = element(2, Point),
  case X1 == X2 orelse Y1 == Y2 of
    true ->
      min_area_rect_helper(Rest, Seen, X1, Y1, MinArea);
    false ->
      case sets:is_element({X1, Y2}, Seen) andalso sets:is_element({X2, Y1}, Seen) of
        true ->
          Area = abs(X1 - X2) * abs(Y1 - Y2),
          NewMinArea = min(MinArea, Area);
          min_area_rect_helper(Rest, Seen, X1, Y1, NewMinArea);
        false ->
          min_area_rect_helper(Rest, Seen, X1, Y1, MinArea)
      end
  end.

minAreaRect(Points) ->
  PointsSet = sets:from_list(Points),
  min_area_rect_main(lists:seq(1, length(Points)), PointsSet, 16#7fffffff, Points).

min_area_rect_main([], _PointsSet, MinArea, _Points) ->
  case MinArea == 16#7fffffff of
    true -> 0;
    false -> MinArea
  end;
min_area_rect_main([I | Rest], PointsSet, MinArea, Points) ->
  min_area_rect_main_helper(lists:seq(I + 1, length(Points)), PointsSet, MinArea, Points, I).

min_area_rect_main_helper([], _PointsSet, MinArea, _Points, _I) ->
  min_area_rect_main(Rest, PointsSet, MinArea, Points);
min_area_rect_main_helper([J | Rest], PointsSet, MinArea, Points, I) ->
  {X1, Y1} = lists:nth(I, Points),
  {X2, Y2} = lists:nth(J, Points),
  case X1 == X2 orelse Y1 == Y2 of
    true ->
      min_area_rect_main_helper(Rest, PointsSet, MinArea, Points, I);
    false ->
      case sets:is_element({X1, Y2}, PointsSet) andalso sets:is_element({X2, Y1}, PointsSet) of
        true ->
          Area = abs(X1 - X2) * abs(Y1 - Y2),
          NewMinArea = min(MinArea, Area);
          min_area_rect_main_helper(Rest, PointsSet, NewMinArea, Points, I);
        false ->
          min_area_rect_main_helper(Rest, PointsSet, MinArea, Points, I)
      end
  end.