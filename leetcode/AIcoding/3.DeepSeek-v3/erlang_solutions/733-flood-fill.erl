-spec flood_fill(Image :: [[integer()]], Sr :: integer(), Sc :: integer(), Color :: integer()) -> [[integer()]].
flood_fill(Image, Sr, Sc, Color) ->
    case Image of
        [] -> Image;
        _ ->
            Rows = length(Image),
            Cols = length(hd(Image)),
            OriginalColor = lists:nth(Sc + 1, lists:nth(Sr + 1, Image)),
            if 
                OriginalColor =:= Color -> Image;
                true -> 
                    NewImage = flood_fill_helper(Image, Sr, Sc, Rows, Cols, OriginalColor, Color),
                    NewImage
            end
    end.

flood_fill_helper(Image, Sr, Sc, Rows, Cols, OriginalColor, NewColor) ->
    if
        Sr < 0; Sc < 0; Sr >= Rows; Sc >= Cols -> Image;
        true ->
            Row = lists:nth(Sr + 1, Image),
            Pixel = lists:nth(Sc + 1, Row),
            if
                Pixel =/= OriginalColor -> Image;
                true ->
                    UpdatedRow = setnth(Sc + 1, Row, NewColor),
                    UpdatedImage = setnth(Sr + 1, Image, UpdatedRow),
                    NextImage1 = flood_fill_helper(UpdatedImage, Sr + 1, Sc, Rows, Cols, OriginalColor, NewColor),
                    NextImage2 = flood_fill_helper(NextImage1, Sr - 1, Sc, Rows, Cols, OriginalColor, NewColor),
                    NextImage3 = flood_fill_helper(NextImage2, Sr, Sc + 1, Rows, Cols, OriginalColor, NewColor),
                    NextImage4 = flood_fill_helper(NextImage3, Sr, Sc - 1, Rows, Cols, OriginalColor, NewColor),
                    NextImage4
            end
    end.

setnth(1, [_|T], X) -> [X|T];
setnth(N, [H|T], X) -> [H|setnth(N-1, T, X)].