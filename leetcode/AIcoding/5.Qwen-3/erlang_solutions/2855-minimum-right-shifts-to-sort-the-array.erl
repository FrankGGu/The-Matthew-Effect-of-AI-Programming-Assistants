-module(minimum_right_shifts_to_sort_the_array).
-export([min_right_shifts/1]).

min_right_shifts(Nums) ->
    N = length(Nums),
    case find_peak(Nums, 0, -1, -1) of
        {ok, Index} ->
            if
                Index == N - 1 -> 0;
                true ->
                    Last = lists:last(Nums),
                    First = lists:nth(1, Nums),
                    if
                        Last =< First -> N - Index - 1;
                        true -> -1
                    end
            end;
        error ->
            -1
    end.

find_peak([], _, _, _) ->
    error;
find_peak([H | T], Index, Max, PeakIndex) ->
    if
        H > Max ->
            find_peak(T, Index + 1, H, Index);
        true ->
            find_peak(T, Index + 1, Max, PeakIndex)
    end.