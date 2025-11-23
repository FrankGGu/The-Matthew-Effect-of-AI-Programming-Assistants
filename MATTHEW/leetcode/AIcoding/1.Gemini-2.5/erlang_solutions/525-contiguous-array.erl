-module(solution).
-export([find_max_length/1]).

find_max_length(Nums) ->
    find_max_length_helper(Nums, 0, 0, #{0 => -1}, 0).

find_max_length_helper([], MaxLen, _CurrentCount, _CountMap, _Index) ->
    MaxLen;
find_max_length_helper([H|T], MaxLen, CurrentCount, CountMap, Index) ->
    NewCount = case H of
                   0 -> CurrentCount - 1;
                   1 -> CurrentCount + 1
               end,

    case maps:is_key(NewCount, CountMap) of
        true ->
            PrevIndex = maps:get(NewCount, CountMap),
            NewMaxLen = max(MaxLen, Index - PrevIndex),
            find_max_length_helper(T, NewMaxLen, NewCount, CountMap, Index + 1);
        false ->
            NewCountMap = maps:put(NewCount, Index, CountMap),
            find_max_length_helper(T, MaxLen, NewCount, NewCountMap, Index + 1)
    end.