-module(solution).
-export([flood_fill/4]).

flood_fill(Image, Sr, Sc, NewColor) ->
    Rows = length(Image),
    Cols = length(hd(Image)),
    OldColor = lists:nth(Sc + 1, lists:nth(Sr + 1, Image)),

    if OldColor == NewColor ->
        Image;
    true ->
        dfs(Image, Sr, Sc, OldColor, NewColor, Rows, Cols)
    end.

dfs(Image, R, C, OldColor, NewColor, MaxRows, MaxCols) ->
    if R < 0; R >= MaxRows; C < 0; C >= MaxCols ->
        Image;
    true ->
        CurrentColor = lists:nth(C + 1, lists:nth(R + 1, Image)),
        if CurrentColor /= OldColor ->
            Image;
        true ->
            UpdatedRow = lists:replace_nth(C + 1, NewColor, lists:nth(R + 1, Image)),
            UpdatedImage = lists:replace_nth(R + 1, UpdatedRow, Image),

            Image1 = dfs(UpdatedImage, R + 1, C, OldColor, NewColor, MaxRows, MaxCols),
            Image2 = dfs(Image1, R - 1, C, OldColor, NewColor, MaxRows, MaxCols),
            Image3 = dfs(Image2, R, C + 1, OldColor, NewColor, MaxRows, MaxCols),
            Image4 = dfs(Image3, R, C - 1, OldColor, NewColor, MaxRows, MaxCols),
            Image4
        end
    end.