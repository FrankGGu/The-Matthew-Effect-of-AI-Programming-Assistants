-module(merge_two_sorted_lists).
-export([merge/2]).

merge(nil, nil) -> nil;
merge(nil, List) -> List;
merge(List, nil) -> List;
merge(#{} = L1, #{} = L2) ->
    case maps:get(value, L1) < maps:get(value, L2) of
        true -> 
            maps:put(next, merge(maps:get(next, L1), L2), L1);
        false ->
            maps:put(next, merge(maps:get(next, L2), L1), L2)
    end.