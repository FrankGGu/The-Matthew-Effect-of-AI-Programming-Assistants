-module(solution).
-export([number_of_rectangles_that_can_form_the_largest_square/1]).

number_of_rectangles_that_can_form_the_largest_square(Rectangles) ->
    MaxSides = lists:map(fun([L, W]) -> min(L, W) end, Rectangles),
    LargestPossibleSide = lists:max(MaxSides),
    lists:foldl(fun(Side, Count) ->
                    if Side == LargestPossibleSide -> Count + 1;
                       true -> Count
                    end
                end, 0, MaxSides).