-module(peak_element).
-export([find_peak/1]).

find_peak(Nums) ->
    find_peak(Nums, 0, length(Nums) - 1).

find_peak(_, Left, Right) when Left == Right ->
    Left;

find_peak(Nums, Left, Right) ->
    Mid = (Left + Right) div 2,
    case lists:nth(Mid + 1, Nums) > lists:nth(Mid, Nums) of
        true -> find_peak(Nums, Mid + 1, Right);
        false -> find_peak(Nums, Left, Mid)
    end.