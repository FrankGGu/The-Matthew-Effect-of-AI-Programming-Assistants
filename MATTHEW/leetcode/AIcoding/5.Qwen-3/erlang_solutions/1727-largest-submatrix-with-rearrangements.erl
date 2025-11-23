-module(largest_submatrix_with_rearrangements).
-export([largestSubmatrix/1]).

largestSubmatrix(Matrix) ->
    Rows = length(Matrix),
    Cols = length(hd(Matrix)),
    Max = 0,
    H = lists:seq(0, Rows - 1),
    lists:foldl(fun(RowIndex, Acc) ->
        NewH = lists:zipwith(fun(HVal, Val) -> if Val == 1 -> HVal + 1; true -> 0 end end, H, lists:nth(RowIndex + 1, Matrix)),
        SortedH = lists:reverse(lists:sort(NewH)),
        lists:foldl(fun({Height, Index}, {MaxSoFar, Current}) ->
            if Height > 0 ->
                NewCurrent = Current + Height,
                NewMax = max(MaxSoFar, NewCurrent),
                {NewMax, NewCurrent};
            true ->
                {MaxSoFar, 0}
            end
        end, {Acc, 0}, lists:enumerate(SortedH))
    end, 0, H).

lists:enumerate(List) ->
    lists:zip(lists:seq(1, length(List)), List).