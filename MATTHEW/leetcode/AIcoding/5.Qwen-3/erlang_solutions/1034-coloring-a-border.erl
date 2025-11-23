-module(coloring_a_border).
-export([colorBorder/3]).

colorBorder(Image, Color, [X,Y]) ->
    Rows = length(Image),
    Cols = length(hd(Image)),
    OriginalColor = lists:nth(X+1, Image) -- Y,
    if
        OriginalColor == Color -> Image;
        true -> dfs(Image, X, Y, OriginalColor, Color, Rows, Cols, sets:new())
    end.

dfs(Image, X, Y, OriginalColor, NewColor, Rows, Cols, Visited) ->
    case sets:is_element({X,Y}, Visited) of
        true -> Image;
        false ->
            NewVisited = sets:add_element({X,Y}, Visited),
            Neighbors = getNeighbors(X, Y, Rows, Cols),
            IsBorder = isBorder(Neighbors, Image, X, Y, OriginalColor),
            UpdatedImage = updateImage(Image, X, Y, NewColor),
            lists:foldl(fun(Next, Acc) ->
                            dfs(Acc, element(1, Next), element(2, Next), OriginalColor, NewColor, Rows, Cols, NewVisited)
                        end, UpdatedImage, Neighbors)
    end.

getNeighbors(X, Y, Rows, Cols) ->
    Directions = [{-1,0}, {1,0}, {0,-1}, {0,1}],
    lists:filter(fun({DX, DY}) ->
                     NX = X + DX,
                     NY = Y + DY,
                     NX >= 0 andalso NX < Rows andalso NY >= 0 andalso NY < Cols
                 end, Directions).

isBorder(Neighbors, Image, X, Y, OriginalColor) ->
    lists:any(fun({DX, DY}) ->
                  NX = X + DX,
                  NY = Y + DY,
                  lists:nth(NX+1, Image) -- NY /= OriginalColor
              end, Neighbors).

updateImage(Image, X, Y, Color) ->
    Row = lists:nth(X+1, Image),
    NewRow = lists:sublist(Row, Y) ++ [Color] ++ lists:nthtail(Y+1, Row),
    lists:sublist(Image, X) ++ [NewRow] ++ lists:nthtail(X+1, Image).