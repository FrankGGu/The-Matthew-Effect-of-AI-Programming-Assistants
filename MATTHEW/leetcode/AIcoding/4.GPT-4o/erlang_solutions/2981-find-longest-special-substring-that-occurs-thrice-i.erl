-module(solution).
-export([find_longest_special_substring/1]).

find_longest_special_substring(S) ->
    Length = length(S),
    find_longest(S, Length, 0).

find_longest(S, Length, MaxLen) when Length > 0 ->
    Sub = lists:sublist(S, Length),
    if
        count_occurrences(Sub, S) =:= 3 ->
            MaxLen = max(MaxLen, Length);
        true ->
            MaxLen
    end,
    find_longest(S, Length - 1, MaxLen);
find_longest(_, 0, MaxLen) ->
    MaxLen.

count_occurrences(Sub, S) ->
    lists:foldl(fun(_, Acc) -> Acc + 1 end, 0, lists:filter(fun(X) -> X == Sub end, substrings(S))).

substrings([]) -> [[]];
substrings(List) ->
    [lists:sublist(List, 0, N) || N <- lists:seq(1, length(List))] ++
    [lists:sublist(List, Start, Len) || Start <- lists:seq(1, length(List)), Len <- lists:seq(1, length(List) - Start + 1)].