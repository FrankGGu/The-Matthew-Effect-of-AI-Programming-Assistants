-module(solution).
-export([max_length_substring/1]).

max_length_substring(Str) ->
    MaxLen = 0,
    Length = string:length(Str),
    lists:foldl(fun(C, {Index, Count, Max}) ->
        NewCount = if C == $a -> Count + 1; true -> Count end,
        NewMax = if NewCount =< 2 -> Max; true -> lists:max([Max, Index + 1 - lists:last(lists:seq(1, NewCount))]) end,
        {Index + 1, NewCount, NewMax}
    end, {0, 0, MaxLen}, string:to_list(Str))#3.