-module(sliding_window_median).
-export([median_sliding_window/2]).

median_sliding_window(Nums, K) ->
    Window = lists:sublist(Nums, K),
    Medians = [median(Window) | slide(Nums, K, K, Window)],
    Medians.

slide(_, _, Length, _) when Length =:= 0 -> [];
slide(Nums, K, Index, Window) when Index < length(Nums) ->
    NewWindow = tl(Window) ++ [lists:nth(Index + 1, Nums)],
    [median(NewWindow) | slide(Nums, K, Index + 1, NewWindow)];
slide(_, _, _, _) -> [].

median(Window) ->
    Sorted = lists:sort(Window),
    Len = length(Sorted),
    case Len rem 2 of
        1 -> lists:nth(Len div 2 + 1, Sorted);
        0 -> (lists:nth(Len div 2, Sorted) + lists:nth(Len div 2 + 1, Sorted)) / 2
    end.