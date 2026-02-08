-module(solution).
-export([maximum_white_tiles/2]).

maximum_white_tiles(tiles, carpet_length) ->
    SortedTiles = lists:sort(tiles),
    MaxWhiteTiles(SortedTiles, carpet_length, 0, 0).

MaxWhiteTiles([], _, _, Acc) -> Acc;
MaxWhiteTiles([{Start, End} | Rest], CarpetLength, Covered, Acc) ->
    Total = End - Start + 1,
    NewCovered = Covered + Total,
    NewAcc = max(NewCovered, Acc),
    if
        CarpetLength >= NewCovered -> 
            MaxWhiteTiles(Rest, CarpetLength, NewCovered, NewAcc);
        true -> 
            RemainingCarpet = CarpetLength - Covered,
            NewStart = Start + RemainingCarpet,
            NewCovered2 = lists:foldl(fun({S, E}, Acc2) -> 
                if S <= NewStart -> Acc2 + max(0, E - NewStart + 1) 
                else Acc2 end 
            end, 0, Rest),
            NewAcc2 = max(NewCovered, NewAcc + NewCovered2),
            NewAcc2
    end.