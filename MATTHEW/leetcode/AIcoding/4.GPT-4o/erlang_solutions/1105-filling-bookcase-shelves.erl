-module(solution).
-export([min_height_shelves/2]).

min_height_shelves(Bookcase, ShelfWidth) ->
    MinHeight = min_height_shelves(Bookcase, ShelfWidth, 1, 0, 0, 0),
    MinHeight.

min_height_shelves([], _, Height, _, _, _) -> Height;
min_height_shelves([{W, H} | Rest], ShelfWidth, Height, CurrentWidth, CurrentHeight, CumulativeHeight) ->
    NewCumulativeHeight = if CurrentWidth + W =< ShelfWidth -> 
                               CumulativeHeight; 
                           true -> 
                               min_height_shelves(Rest, ShelfWidth, CumulativeHeight + CurrentHeight, W, H, H) 
                           end,
    min_height_shelves(Rest, ShelfWidth, Height, CurrentWidth + W, max(CurrentHeight, H), NewCumulativeHeight).