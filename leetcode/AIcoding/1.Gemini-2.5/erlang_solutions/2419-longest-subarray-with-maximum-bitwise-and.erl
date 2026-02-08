-module(solution).
-export([longestSubarray/1]).

longestSubarray(Nums) ->
    MaxVal = lists:max(Nums),
    find_longest_consecutive_max(Nums, MaxVal, 0, 0).

find_longest_consecutive_max([], _MaxVal, _CurrentLength, MaxLength) ->
    MaxLength;
find_longest_consecutive_max([H|T], MaxVal, CurrentLength, MaxLength) ->
    if H == MaxVal ->
        NewCurrentLength = CurrentLength + 1,
        NewMaxLength = max(MaxLength, NewCurrentLength),
        find_longest_consecutive_max(T, MaxVal, NewCurrentLength, NewMaxLength);
    true ->
        find_longest_consecutive_max(T, MaxVal, 0, MaxLength)
    end.