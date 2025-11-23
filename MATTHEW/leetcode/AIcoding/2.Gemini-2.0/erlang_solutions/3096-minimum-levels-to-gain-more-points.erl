-module(minimum_levels).
-export([minimum_levels/1]).

minimum_levels(Energy) ->
    minimum_levels_helper(Energy, 0, 0).

minimum_levels_helper([], Levels, Max) ->
    {Levels, Max};
minimum_levels_helper([E | Rest], Levels, Max) ->
    case E > Max of
        true ->
            minimum_levels_helper(Rest, Levels + 1, E);
        false ->
            minimum_levels_helper(Rest, Levels, Max)
    end.