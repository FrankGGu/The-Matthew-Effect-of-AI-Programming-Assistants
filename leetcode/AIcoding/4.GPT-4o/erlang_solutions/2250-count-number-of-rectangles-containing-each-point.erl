-module(solution).
-export([countRectangles/2]).

countRectangles(Rectangles, Points) ->
    RectCount = lists:map(fun({X1, Y1, X2, Y2}) -> {X1, Y1, X2, Y2} end, Rectangles),
    lists:map(fun({X, Y}) -> 
        lists:foldl(fun({X1, Y1, X2, Y2}, Acc) -> 
            if 
                X1 =< X, X =< X2, Y1 =< Y, Y =< Y2 -> 
                    Acc + 1; 
                true -> 
                    Acc 
            end 
        end, 0, RectCount) 
    end, Points).