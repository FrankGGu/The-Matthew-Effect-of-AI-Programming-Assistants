-module(solution).
-export([find_longest_balanced_substring/1]).

find_longest_balanced_substring(BinaryString) ->
    Length = length(BinaryString),
    find_longest(BinaryString, Length, 0, 0, 0).

find_longest(<<>>, _Length, Count0, Count1, Max) ->
    max(Count0, Count1);
find_longest(<<C:1, Rest/binary>>, Length, Count0, Count1, Max) when C =:= 0 ->
    find_longest(Rest, Length, Count0 + 1, Count1, max(Max, min(Count0 + 1, Count1)));
find_longest(<<C:1, Rest/binary>>, Length, Count0, Count1, Max) when C =:= 1 ->
    find_longest(Rest, Length, Count0, Count1 + 1, max(Max, min(Count0, Count1 + 1))).