-module(count_rectangles).
-export([count_rectangles/2]).

count_rectangles(rectangles, points) ->
  lists:map(fun(Point) -> count_rectangles_for_point(rectangles, Point) end, points).

count_rectangles_for_point(Rectangles, {X, Y}) ->
  lists:foldl(fun({A, B}, Acc) ->
                  if A >= X and B >= Y ->
                    Acc + 1
                  else
                    Acc
                  end
              end, 0, Rectangles).