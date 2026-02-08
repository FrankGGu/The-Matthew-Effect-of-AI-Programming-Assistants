-module(solve).
-export([lexicographically_smallest/2]).

lexicographically_smallest(Arr, K) ->
    lexicographically_smallest(Arr, K, 0).

lexicographically_smallest([], _, _) ->
    [];
lexicographically_smallest(Arr, K, Index) ->
    if
        Index >= length(Arr) -> Arr;
        true ->
            MinPos = find_min_pos(Arr, Index, min_index(Arr, Index, Index, 0)),
            if
                MinPos - Index =< K ->
                    Swap = lists:sublist(Arr, Index, MinPos - Index + 1),
                    Remaining = lists:nthtail(MinPos + 1, Arr),
                    NewArr = lists:append(Swap, Remaining),
                    lexicographically_smallest(NewArr, K - (MinPos - Index), Index + 1);
                true ->
                    lexicographically_smallest(Arr, K, Index + 1)
            end
    end.

min_index(_, _, Pos, MinPos) when Pos >= length(_) -> MinPos;
min_index(Arr, Start, Pos, MinPos) ->
    if
        lists:nth(Pos, Arr) < lists:nth(MinPos, Arr) -> min_index(Arr, Start, Pos + 1, Pos);
        true -> min_index(Arr, Start, Pos + 1, MinPos)
    end.

find_min_pos(Arr, Start, MinPos) when MinPos < Start -> find_min_pos(Arr, Start, Start);
find_min_pos(Arr, Start, MinPos) ->
    if
        MinPos >= length(Arr) -> MinPos;
        lists:nth(MinPos, Arr) < lists:nth(Start, Arr) -> find_min_pos(Arr, Start, MinPos + 1);
        true -> MinPos
    end.