-module(rectangles).
-export([count_largest_squares/1]).

count_largest_squares(Rectangles) ->
    MaxSide = lists:max([lists:min(R) || R <- Rectangles]),
    lists:foldl(fun(R, Acc) -> if lists:min(R) == MaxSide -> Acc + 1; true -> Acc end end, 0, Rectangles).