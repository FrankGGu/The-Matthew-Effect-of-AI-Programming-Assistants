-module(image_smoother).
-export([image_smoother/1]).

image_smoother(Img) ->
  Rows = length(Img),
  Cols = length(hd(Img)),
  Result = lists:map(
             fun(R) ->
               lists:map(
                 fun(C) ->
                   Sum = get_sum(Img, R, C, Rows, Cols),
                   Count = get_count(Img, R, C, Rows, Cols),
                   Sum div Count
                 end,
                 lists:seq(0, Cols - 1)
               )
             end,
             lists:seq(0, Rows - 1)
           ),
  Result.

get_sum(Img, R, C, Rows, Cols) ->
  Sum = 0,
  for(MaxR = min(R + 1, Rows - 1), R - 1 =< MaxR, 1,
    for(MaxC = min(C + 1, Cols - 1), C - 1 =< MaxC, 1,
      Sum = Sum + lists:nth(MaxC + 1, lists:nth(MaxR + 1, Img))
    )
  ),
  Sum.

get_count(Img, R, C, Rows, Cols) ->
  Count = 0,
  for(MaxR = min(R + 1, Rows - 1), R - 1 =< MaxR, 1,
    for(MaxC = min(C + 1, Cols - 1), C - 1 =< MaxC, 1,
      Count = Count + 1
    )
  ),
  Count.