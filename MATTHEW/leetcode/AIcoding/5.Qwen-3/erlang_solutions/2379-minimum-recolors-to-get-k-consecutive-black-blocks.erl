-module(min_recolors).
-export([minimumRecolors/1]).

minimumRecols(Blocks) ->
    minimumRecols(Blocks, 0, 0, length(Blocks), 0).

minimumRecols([], _, _, _, Min) ->
    Min;
minimumRecols([H|T], Count, Pos, Len, Min) ->
    if
        H == $B ->
            NewCount = Count + 1,
            if
                Pos + 1 >= Len ->
                    minimumRecols(T, NewCount, Pos + 1, Len, min(Min, NewCount));
                true ->
                    minimumRecols(T, NewCount, Pos + 1, Len, Min)
            end;
        true ->
            if
                Pos + 1 >= Len ->
                    minimumRecols(T, 0, Pos + 1, Len, min(Min, 0));
                true ->
                    minimumRecols(T, 0, Pos + 1, Len, Min)
            end
    end.