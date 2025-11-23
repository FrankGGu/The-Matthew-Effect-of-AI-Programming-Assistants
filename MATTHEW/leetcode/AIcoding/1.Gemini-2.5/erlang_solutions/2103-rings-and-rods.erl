-module(solution).
-export([count_points/1]).

count_points(Rings) ->
    % Convert the input string to a list of characters for easier processing.
    RingsList = string:to_list(Rings),

    % Process all rings to build a map where keys are rod numbers
    % and values are ordsets of colors present on that rod.
    RodColors = build_rod_colors_map(RingsList, maps:new()),

    % Define the target set of colors (R, G, B) that a rod must have.
    TargetColors = ordsets:from_list([$R, $G, $B]),

    % Iterate through the RodColors map and count how many rods have all three colors.
    Count = maps:fold(fun(_RodNum, ColorsOnRod, Acc) ->
                              if ordsets:is_subset(TargetColors, ColorsOnRod) ->
                                     Acc + 1;
                                 true ->
                                     Acc
                              end
                      end, 0, RodColors),
    Count.

build_rod_colors_map([], AccMap) ->
    AccMap;
build_rod_colors_map([Color, RodChar | Rest], AccMap) ->
    % Convert the character rod number to an integer.
    RodNum = RodChar - $0,

    % Get the current set of colors for this rod, or an empty set if it's new.
    CurrentColors = maps:get(RodNum, AccMap, ordsets:new()),

    % Add the new color to the set.
    NewColors = ordsets:add_element(Color, CurrentColors),

    % Update the map with the new set of colors for this rod.
    UpdatedMap = maps:put(RodNum, NewColors, AccMap),

    % Continue processing the rest of the rings.
    build_rod_colors_map(Rest, UpdatedMap).