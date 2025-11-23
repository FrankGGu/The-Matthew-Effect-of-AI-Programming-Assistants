-module(solution).
-export([smallest_range/1]).

smallest_range(Lists) ->
    K = length(Lists),
    SortedLists = [lists:sort(List) || List <- Lists],
    {Min, Max} = find_min_max(SortedLists),
    smallest_range_helper(SortedLists, {Min, Max}, K, 0, []).

find_min_max(Lists) ->
    Min = lists:min(lists:flatten(Lists)),
    Max = lists:max(lists:flatten(Lists)),
    {Min, Max}.

smallest_range_helper(Lists, {Min, Max}, K, Index, CurrentRange) ->
    if
        Index >= K -> CurrentRange;
        true -> 
            {NewMin, NewMax} = get_new_min_max(Lists, Index),
            NewRange = {NewMin, NewMax},
            if
                (NewMax - NewMin) < (Max - Min) -> 
                    smallest_range_helper(Lists, NewRange, Index + 1, NewRange);
                true -> 
                    smallest_range_helper(Lists, {Min, Max}, Index + 1, CurrentRange)
            end
    end.

get_new_min_max(Lists, Index) ->
    Min = lists:min(lists:nth(Index + 1, Lists)),
    Max = lists:max(lists:nth(Index + 1, Lists)),
    {Min, Max}.