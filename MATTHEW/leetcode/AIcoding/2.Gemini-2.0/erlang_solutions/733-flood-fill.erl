-module(flood_fill).
-export([flood_fill/3]).

flood_fill(Image, StartRow, StartCol, NewColor) ->
    Color = lists:nth(StartCol + 1, lists:nth(StartRow + 1, Image)),
    flood_fill_helper(Image, StartRow, StartCol, Color, NewColor).

flood_fill_helper(Image, Row, Col, Color, NewColor) ->
    Rows = length(Image),
    Cols = length(lists:nth(1, Image)),
    if
        Row < 0 orelse Row >= Rows orelse Col < 0 orelse Col >= Cols ->
            Image;
        true ->
            PixelColor = lists:nth(Col + 1, lists:nth(Row + 1, Image)),
            if
                PixelColor /= Color ->
                    Image;
                true ->
                    NewImage = replace_pixel(Image, Row, Col, NewColor),
                    NewImage1 = flood_fill_helper(NewImage, Row - 1, Col, Color, NewColor),
                    NewImage2 = flood_fill_helper(NewImage1, Row + 1, Col, Color, NewColor),
                    NewImage3 = flood_fill_helper(NewImage2, Row, Col - 1, Color, NewColor),
                    flood_fill_helper(NewImage3, Row, Col + 1, Color, NewColor)
            end
    end.

replace_pixel(Image, Row, Col, NewColor) ->
    lists:map(
        fun(RowIndex, Row) ->
            if RowIndex == Row + 1 then
                lists:map(
                    fun(ColIndex, Pixel) ->
                        if ColIndex == Col + 1 then
                            NewColor
                        else
                            Pixel
                        end
                    end,
                    lists:seq(1, length(Row)), Row
                )
            else
                Row
            end
        end,
        lists:seq(1, length(Image)), Image
    ).