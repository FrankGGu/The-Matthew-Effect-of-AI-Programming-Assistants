-module(solution).
-export([countGoodRectangles/1]).

countGoodRectangles(Rectangles) ->
    MaxLen = lists:max(lists:map(fun({W, H}) -> min(W, H) end, Rectangles)),
    lists:foldl(fun({W, H}, Acc) -> 
                    if 
                        min(W, H) =:= MaxLen -> Acc + 1; 
                        true -> Acc 
                    end 
                end, 0, Rectangles).