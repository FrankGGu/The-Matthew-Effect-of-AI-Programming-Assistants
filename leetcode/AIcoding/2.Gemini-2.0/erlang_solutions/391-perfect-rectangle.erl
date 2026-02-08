-module(perfect_rectangle).
-export([is_rectangle_cover/1]).

is_rectangle_cover(rectangles) ->
  {Area, Points} = lists:foldl(fun({X1, Y1, X2, Y2}, {AccArea, AccPoints}) ->
                                   {AccArea + (X2 - X1) * (Y2 - Y1),
                                    maps:put({X1, Y1}, not maps:is_key({X1, Y1}, AccPoints),
                                             maps:put({X1, Y2}, not maps:is_key({X1, Y2}, AccPoints),
                                                      maps:put({X2, Y1}, not maps:is_key({X2, Y1}, AccPoints),
                                                               maps:put({X2, Y2}, not maps:is_key({X2, Y2}, AccPoints), AccPoints))))}
                                end, {0, maps:new()}, rectangles),

  UniquePoints = maps:fold(fun(_Key, Value, Acc) ->
                                  case Value of
                                    true -> Acc + 1;
                                    false -> Acc
                                  end
                              end, 0, Points),

  case length(rectangles) > 0 of
    true ->
      {MinX, MinY, MaxX, MaxY} = lists:foldl(fun({X1, Y1, X2, Y2}, {AccMinX, AccMinY, AccMaxX, AccMaxY}) ->
                                                 {min(AccMinX, X1), min(AccMinY, Y1), max(AccMaxX, X2), max(AccMaxY, Y2)}
                                             end, {hd(rectangles)!!1, hd(rectangles)!!2, hd(rectangles)!!3, hd(rectangles)!!4}, rectangles),
      ExpectedArea = (MaxX - MinX) * (MaxY - MinY),
      UniquePoints == 4 andalso Area == ExpectedArea andalso
        maps:is_key({MinX, MinY}, Points) andalso maps:is_key({MinX, MaxY}, Points) andalso
        maps:is_key({MaxX, MinY}, Points) andalso maps:is_key({MaxX, MaxY}, Points);
    false ->
      true
  end.