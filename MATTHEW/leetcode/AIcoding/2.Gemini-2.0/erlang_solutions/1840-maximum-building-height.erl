-module(maximum_building_height).
-export([maximum_building_height/2]).

maximum_building_height(N, Restrictions) ->
    SortedRestrictions = lists:sort(Restrictions),
    RestrictionsWithEndpoints = [{1, 0} | SortedRestrictions] ++ [{N, N}],
    AdjustedRestrictions = adjust_restrictions(RestrictionsWithEndpoints),
    Heights = calculate_heights(AdjustedRestrictions),
    max(Heights).

adjust_restrictions(Restrictions) ->
    adjust_restrictions_helper(Restrictions, []).

adjust_restrictions_helper([], Acc) ->
    lists:reverse(Acc);
adjust_restrictions_helper([H1 = {Pos1, Height1}, H2 = {Pos2, Height2} | T], Acc) ->
    Distance = abs(Pos2 - Pos1),
    HeightDiff = abs(Height2 - Height1),
    if Distance >= HeightDiff then
        adjust_restrictions_helper([H2 | T], [H1 | Acc])
    else
        NewHeight2 = Height1 + Distance,
        adjust_restrictions_helper([{Pos2, NewHeight2} | T], [H1 | Acc])
    end.

calculate_heights(Restrictions) ->
    calculate_heights_helper(Restrictions, []).

calculate_heights_helper([], Acc) ->
    lists:reverse(Acc);
calculate_heights_helper([H1 = {Pos1, Height1}, H2 = {Pos2, Height2} | T], Acc) ->
    Distance = abs(Pos2 - Pos1),
    MaxHeight = (Height1 + Height2 + Distance) div 2,
    calculate_heights_helper([H2 | T], [MaxHeight | Acc]).