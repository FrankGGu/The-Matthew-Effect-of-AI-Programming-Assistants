-module(count_covered_buildings).
-export([number_of_visible_buildings/1]).

number_of_visible_buildings(Buildings) ->
    number_of_visible_buildings(Buildings, 0, -1).

number_of_visible_buildings([], Count, _) ->
    Count;
number_of_visible_buildings([H | T], Count, MaxHeight) ->
    if
        H > MaxHeight ->
            number_of_visible_buildings(T, Count + 1, H);
        true ->
            number_of_visible_buildings(T, Count, MaxHeight)
    end.