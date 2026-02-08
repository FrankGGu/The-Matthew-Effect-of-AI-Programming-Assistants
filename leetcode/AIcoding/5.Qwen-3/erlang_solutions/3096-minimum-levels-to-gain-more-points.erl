-module(minimum_levels_to_gain_more_points).
-export([min_levels/1]).

min_levels(Points) ->
    Total = lists:sum(Points),
    Left = 0,
    Right = Total,
    min_levels(Points, Left, Right, 0).

min_levels([], _, _, Acc) ->
    Acc;
min_levels([P | T], Left, Right, Acc) ->
    NewLeft = Left + P,
    NewRight = Right - P,
    if
        NewLeft > NewRight ->
            Acc + 1;
        true ->
            min_levels(T, NewLeft, NewRight, Acc + 1)
    end.