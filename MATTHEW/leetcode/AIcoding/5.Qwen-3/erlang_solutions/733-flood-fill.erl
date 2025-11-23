-module(flood_fill).
-export([flood_fill/3]).

flood_fill(Image, SR, SC) ->
    Rows = length(Image),
    if
        SR < 0 orelse SR >= Rows -> Image;
        true ->
            Cols = length(hd(Image)),
            if
                SC < 0 orelse SC >= Cols -> Image;
                true ->
                    OriginalColor = lists:nth(SR + 1, Image) -- [SC],
                    if
                        OriginalColor == 0 -> Image;
                        true -> dfs(Image, SR, SC, OriginalColor, 0)
                    end
            end
    end.

dfs(Image, SR, SC, OriginalColor, NewColor) ->
    Rows = length(Image),
    Cols = length(hd(Image)),
    if
        SR < 0 orelse SR >= Rows orelse SC < 0 orelse SC >= Cols -> Image;
        true ->
            CurrentColor = lists:nth(SR + 1, Image) -- [SC],
            if
                CurrentColor /= OriginalColor -> Image;
                true ->
                    UpdatedRow = lists:sublist(hd(Image), SC) ++ [NewColor] ++ lists:nthtail(SC + 1, hd(Image)),
                    UpdatedImage = lists:substitute(hd(Image), UpdatedRow, Image),
                    dfs(UpdatedImage, SR - 1, SC, OriginalColor, NewColor),
                    dfs(UpdatedImage, SR + 1, SC, OriginalColor, NewColor),
                    dfs(UpdatedImage, SR, SC - 1, OriginalColor, NewColor),
                    dfs(UpdatedImage, SR, SC + 1, OriginalColor, NewColor),
                    UpdatedImage
            end
    end.