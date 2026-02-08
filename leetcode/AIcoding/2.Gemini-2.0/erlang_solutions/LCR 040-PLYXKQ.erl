-module(largestRectangleArea).
-export([largestRectangleArea/1]).

largestRectangleArea(Matrix) ->
  case Matrix of
    [] ->
      0;
    _ ->
      largestRectangleAreaHelper(Matrix)
  end.

largestRectangleAreaHelper(Matrix) ->
  Rows = length(Matrix),
  Cols = length(hd(Matrix)),
  Heights = lists:duplicate(Cols, 0),
  lists:foldl(
    fun(Row, MaxArea) ->
      NewHeights = updateHeights(Row, Heights),
      max(MaxArea, largestRectangleAreaHistogram(NewHeights))
    end,
    0,
    Matrix
  ).

updateHeights(Row, Heights) ->
  lists:zipwith(
    fun(Val, Height) ->
      case Val of
        1 -> Height + 1;
        0 -> 0
      end
    end,
    Row,
    Heights
  ).

largestRectangleAreaHistogram(Heights) ->
  Stack = [],
  largestRectangleAreaHistogramHelper(Heights, 0, Stack, 0).

largestRectangleAreaHistogramHelper([], _Idx, Stack, MaxArea) ->
  largestRectangleAreaHistogramHelper2(Stack, length(Heights), MaxArea);
largestRectangleAreaHistogramHelper([H|Rest], Idx, Stack, MaxArea) ->
  case Stack of
    [] ->
      largestRectangleAreaHistogramHelper(Rest, Idx + 1, [{H, Idx}], MaxArea);
    [{TopH, TopIdx}|_] ->
      case H >= TopH of
        true ->
          largestRectangleAreaHistogramHelper(Rest, Idx + 1, [{H, Idx}|Stack], MaxArea);
        false ->
          Area = TopH * (Idx - TopIdx),
          largestRectangleAreaHistogramHelper(
            [H|Rest],
            Idx,
            tl(Stack),
            max(MaxArea, Area)
          )
      end
  end.

largestRectangleAreaHistogramHelper2([], _Len, MaxArea) ->
  MaxArea;
largestRectangleAreaHistogramHelper2([{H, Idx}|Rest], Len, MaxArea) ->
  Area = H * (Len - Idx),
  largestRectangleAreaHistogramHelper2(Rest, Len, max(MaxArea, Area)).