-module(solution).

-export([flood_fill/4]).

flood_fill(Image, Sr, Sc, NewColor) ->
    OldColor = lists:nth(1, lists:nth(Sr + 1, Image)),
    if
        OldColor =:= NewColor -> Image;
        true -> flood_fill_helper(Image, Sr, Sc, OldColor, NewColor)
    end.

flood_fill_helper(Image, Sr, Sc, OldColor, NewColor) ->
    case get_pixel(Image, Sr, Sc) of
        OldColor ->
            Image1 = set_pixel(Image, Sr, Sc, NewColor),
            Image1 = flood_fill_helper(Image1, Sr + 1, Sc, OldColor, NewColor),
            Image1 = flood_fill_helper(Image1, Sr - 1, Sc, OldColor, NewColor),
            Image1 = flood_fill_helper(Image1, Sr, Sc + 1, OldColor, NewColor),
            flood_fill_helper(Image1, Sr, Sc - 1, OldColor, NewColor);
        _ -> Image
    end.

get_pixel(Image, R, C) ->
    case lists:nth(R + 1, Image) of
        Row -> lists:nth(C + 1, Row);
        _ -> -1
    end.

set_pixel(Image, R, C, Color) ->
    NewRow = lists:nth(R + 1, Image) ++ [Color],
    lists:map(fun(Row, Index) ->
        if Index =:= R -> NewRow;
        true -> Row
        end
    end, Image, lists:seq(0, length(Image) - 1)).